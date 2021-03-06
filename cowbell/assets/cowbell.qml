/* Copyright (c) 2012 Research In Motion Limited.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
import bb.cascades 1.0

// The application page with a Container as content, all UI components are children to that Container.
Page {

    Container {
        layout: AbsoluteLayout {
        }

        // Background ImageView.
        ImageView {
            imageSource: "asset:///images/background.png"

            // If we touch the background we want a moo to sound.
            onTouch: {
                if (event.isDown ()) {
                    cowbellApp.playSound ("moo.wav");
                }
            }
        }

        // The bell.
        ImageView {
            id: bell
            imageSource: "asset:///images/bell.png"
            preferredWidth: 503
            preferredHeight: 768
            layoutProperties: AbsoluteLayoutProperties {
                positionX: 582
                positionY: -50
            }

            // The bell should rotate around a point located in the middle of
            // the image in x-direction and located somewhere above the screen
            // in y (it hangs around the neck of the cow which is not visible).
            // If the center is not altered all rotation animations will be around
            // the middle of the image.
            pivotY: -600

            // We need two animations, one to swing to the left and one to swing to the right.
            animations: [
                SequentialAnimation {
                    id: animLeft
                    animations: [
                        RotateTransition {
                            toAngleZ: -1.5
                            duration: 200
                        },
                        RotateTransition {
                            toAngleZ: 0
                            duration: 200
                        }
                    ]
                },
                SequentialAnimation {
                    id: animRight
                    animations: [
                        RotateTransition {
                            toAngleZ: 1.5
                            duration: 200
                        },
                        RotateTransition {
                            toAngleZ: 0
                            duration: 200
                        }
                    ]
                }
            ]

            // Touch handler for the bell image.
            onTouch: {
                if (event.isDown ()) {

                    // Do not trigger the bell sound if touches occurred on the image, but outside the
                    // actual bell (above or below).
                    if (event.windowY > 140 && event.windowY < (preferredHeight - 60)) {

                        // Play the sound.
                        cowbellApp.playSound ("cowbell.wav");

                        // If the image is hit on the left side swing it to the right.
                        if (event.windowX < bell.layoutProperties.positionX + preferredWidth / 2) {

                            // Stop the animation before playing it to stop the moving bell and
                            // run the animation from that position.
                            animLeft.stop ();
                            animLeft.play ();

                        } else {
                            // And vice versa for the right side.
                            animRight.stop ();
                            animRight.play ();
                        }
                    }
                }
            }
        }
    }

}
