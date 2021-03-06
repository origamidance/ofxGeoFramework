#include "ofApp.h"
#include <igl/remove_duplicate_vertices.h>

#ifdef RUNCODE
REGISTERCLASS(ofApp)
#endif

void ofApp::setup() {
  ofSetLogLevel(OF_LOG_VERBOSE);
  ofSetVerticalSync(false);
  // ofBackground(ofColor(bgColor[0] * 255, bgColor[1] * 255, bgColor[2] * 255));
  // ofBackgroundGradient(ofColor(0,0,0),ofColor(100,100,100),OF_GRADIENT_CIRCULAR);
  //    ofBackground(133,150,220);
  // so the model isn't see through.
  ofEnableDepthTest();
  // load the first model
  model.loadModel("penguin.ply", 20);
  // model info
  curFileInfo = ".stl";
  // this loads in the model directly into a mesh
  // ofMesh can only read in .plys that are in the ascii and not in the binary
  // format.
  bUsingMesh = false;
  mesh.load("penguin.ply");
  // you can create as many rotations as you want
  // choose which axis you want it to effect
  // you can update these rotations later on
  // these rotation set the model so it is oriented correctly
  model.setRotation(0, 90, 1, 0, 0);
  model.setRotation(0, 90, 0, 1, 0);
  //    model.setScale(0.3, 0.3, 0.3);
  model.setScale(0.5, 0.5, 0.5);
  //    model.setPosition(ofGetWidth()/2, ofGetHeight()/2, 0);
  model.setPosition(0, 0, 0);
  light.setPosition(0, 0, 5000);
  mat.setShininess(120);
  mat.setAmbientColor(ofFloatColor::gray);

  // set help text to display by default
  bHelpText = true;

  gui.setup();
  ImGui::GetIO().MouseDrawCursor = false;
  //    backgroundColor = ofColor(114, 144, 154);
  show_test_window = true;
  show_another_window = false;
  floatValue = 0.0f;
  intValue = 3;
  ofSetCircleResolution(120);

  ofLogVerbose() << "textureSourceID:" << textureSourceID;
}

bool doSetTheme = false;

void ofApp::update() {
  //    model.setRotation(1, 270 + ofGetElapsedTimef() * 60, 0, 1, 0);

  if (doSetTheme) {
    doSetTheme = false;
    gui.setTheme(new ThemeTest());
  }
  if (cam.getMouseInputEnabled()) {
    if (ImGui::IsMouseHoveringAnyWindow()) {
      cam.disableMouseInput();
    }
  } else if (!ImGui::IsMouseHoveringAnyWindow()) {
    cam.enableMouseInput();
  }
}

bool doThemeColorsWindow = false;

void ofApp::draw() {

  ofBackgroundGradient(ofColor(100,100,100),ofColor(0,0,0),OF_GRADIENT_CIRCULAR);
  cam.begin();
  ofEnableLighting();
  light.enable();
  light.setPosition(lightPosArray[0], lightPosArray[1], lightPosArray[2]);
  // light.setAreaLight(100, 100);
  light.setSpotlight();
  light.setSpotlightCutOff(100);
  light.setDiffuseColor(ofColor::white);
  light.lookAt(ofVec3f::zero());
  model.setScale(0.5, 0.5, 0.5);
  model.enableMaterials();
  model.enableNormals();

  // draws all the other file types which are loaded into model.
    //        cam.begin();
    ofDrawAxis(200);
    ofDrawGridPlane(10, 10, false);
    //        ofColor(255, 255, 255);
    mat.begin();
           // ofNoFill();

    // mesh.draw();
    // model.disableColors();
    // ofSetColor(ofColor(100,0,0));
    // model.drawWireframe();
    // model.drawFaces();
    model.draw(OF_MESH_FILL);
    model.draw(OF_MESH_WIREFRAME);
       // ofDrawSphere(20);
    mat.end();
    //        cam.end();

  light.disable();
  ofDisableLighting();
  light.draw();
  cam.end();

  // display help text if it is enable
  if (bHelpText) {
    stringstream ss;
    ss << "FPS: " << ofToString(ofGetFrameRate(), 0) << endl << endl;
    ss << "Current file info: " + curFileInfo << endl;
    if (bUsingMesh) {
      ss << "Use ofEasyCam mouse and key controls to navigate." << endl << endl;
    }
    ss << "(h): Toggle help." << endl;
    ofDrawBitmapString(ss.str().c_str(), 20, 20);
  }

  // required to call this at beginning
  gui.begin();
  // In between gui.begin() and gui.end() you can use ImGui as you would
  // anywhere else

  // 1. Show a simple window
  {
    ImGui::Text("hahaha!");

    // this will change the app background color
    ImGui::DragInt3("light pos", lightPosArray, 1, -1000, 1000);
    if (ImGui::Button("Test Window")) {
      show_test_window = !show_test_window;
    }

    if (ImGui::Button("Another Window")) {
      // bitwise OR
      show_another_window ^= 1;
    }
    if (ImGui::Button("Get snapshot")) {
      snapshot.grabScreen(0, 0, ofGetWidth(), ofGetHeight());
      snapshot.save("snapshot" + std::to_string(ofGetSystemTime()) + ".png");
      std::cout << "snapshot got"
                << "\n";
    }
    if (ImGui::ColorEdit3("Background color", bgColor)) {
      ofBackground(
          ofColor(bgColor[0] * 255, bgColor[1] * 255, bgColor[2] * 255));
    }
    ImGui::Text("Application average %.3f ms/frame (%.1f FPS)",
                1000.0f / ImGui::GetIO().Framerate, ImGui::GetIO().Framerate);
  }
  //     2. Show another window, this time using an explicit ImGui::Begin and
  //     ImGui::End
  if (show_another_window) {
    // note: ofVec2f and ImVec2f are interchangeable
    ImGui::SetNextWindowSize(ofVec2f(200, 100), ImGuiSetCond_FirstUseEver);
    ImGui::Begin("Another Window", &show_another_window);
    ImGui::Text("nihao");
    ImGui::End();
  }

  // 3. Show the ImGui test window. Most of the sample code is in
  // ImGui::ShowTestWindow()
  if (show_test_window) {
    ImGui::SetNextWindowPos(ofVec2f(650, 20), ImGuiSetCond_FirstUseEver);
    ImGui::ShowTestWindow(&show_test_window);
  }

  //    bool pressed = ImGui::ImageButton((ImTextureID) (uintptr_t)
  //    imageButtonID, ImVec2(200, 200));
  //    pressed = ImGui::ImageButton((ImTextureID) (uintptr_t) pixelsButtonID,
  //    ImVec2(200, 200));
  //    pressed = ImGui::ImageButton((ImTextureID) (uintptr_t) textureSourceID,
  //    ImVec2(200, 200));

  if (doThemeColorsWindow) {
    gui.openThemeColorWindow();
  }

  // required to call this at end
  gui.end();

  if (textureSource.isAllocated()) {
    // textureSource.draw(ofRandom(200), ofRandom(200));
  }
}

void ofApp::exit() {}

void ofApp::keyPressed(ofKeyEventArgs &key) {
  ofLogVerbose(__FUNCTION__) << key.key;
  switch (key.key) {
  case 'c':
    if (cam.getMouseInputEnabled())
      cam.disableMouseInput();
    else
      cam.enableMouseInput();
    break;

  case 'f':
    ofToggleFullscreen();
    break;

  case 't': {
    doThemeColorsWindow = !doThemeColorsWindow;
    break;
  }
  case 's': {
    break;
  }
  case 'h':
    // toggle help text
    bHelpText = !bHelpText;
    break;
  default:
    break;
  }
}

void ofApp::keyReleased(ofKeyEventArgs &key) {
  ofLogVerbose(__FUNCTION__) << key.key;
}

void ofApp::mouseMoved(ofMouseEventArgs &mouse) {}

void ofApp::mouseDragged(ofMouseEventArgs &mouse) {}

void ofApp::mousePressed(ofMouseEventArgs &mouse) {}

void ofApp::mouseReleased(ofMouseEventArgs &mouse) {}

void ofApp::mouseScrolled(ofMouseEventArgs &mouse) {
  ofLogVerbose(__FUNCTION__) << "x: " << mouse.x << " y: " << mouse.y;
}

void ofApp::mouseEntered(ofMouseEventArgs &mouse) {}

void ofApp::mouseExited(ofMouseEventArgs &mouse) {}

void ofApp::touchDown(ofTouchEventArgs &touch) {}

void ofApp::touchMoved(ofTouchEventArgs &touch) {}

void ofApp::touchUp(ofTouchEventArgs &touch) {}

void ofApp::touchDoubleTap(ofTouchEventArgs &touch) {}

void ofApp::touchCancelled(ofTouchEventArgs &touch) {}

void ofApp::windowResized(ofResizeEventArgs &window) {}

void ofApp::dragged(ofDragInfo &dragged) {}

void ofApp::messageReceived(ofMessage &message) {}
