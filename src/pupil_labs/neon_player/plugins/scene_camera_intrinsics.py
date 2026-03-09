import json
import logging
from pathlib import Path

from PySide6.QtGui import QIcon
from qt_property_widgets.utilities import action_params

from pupil_labs import neon_player
from pupil_labs.neon_player import action
from pupil_labs.neon_player.utilities import get_scene_intrinsics


class SceneCameraIntrinsicsPlugin(neon_player.Plugin):
    label = "Scene Camera Intrinsics"

    @action
    @action_params(compact=True, icon=QIcon(str(neon_player.asset_path("export.svg"))))
    def export(self, destination: Path = Path()) -> None:
        if self.recording is None:
            return

        scene_camera_matrix, scene_distortion = get_scene_intrinsics(
            self.recording
        )
        intrinsics_file = destination / "scene_camera_intrinsics.json"
        with open(intrinsics_file, "w") as f:
            json.dump(
                {
                    "scene_camera_matrix_K": [
                        row.tolist() for row in scene_camera_matrix
                    ],
                    "scene_distortion_coefficients": scene_distortion.tolist(),
                },
                f,
                indent=2,
            )
        logging.info(f"Wrote {intrinsics_file}")
