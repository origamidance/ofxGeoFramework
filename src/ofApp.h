#pragma once

#ifdef Success
#undef Success
#endif
#include "ofLiveMain.h"
#include "ofxImGui.h"
#include "ThemeTest.h"
#include "ofxAssimpModelLoader.h"
#undef Success
#include <igl/readSTL.h>
#include <Eigen/Core>

#define RED(x) "\033[31m" << x << "\033[0m"

typedef int testint;
class ofApp : public ofLiveApp
{
public:
    void setup();

    void update();

    void draw();

    void exit();

    void keyPressed(ofKeyEventArgs &);

    void keyReleased(ofKeyEventArgs &);

    void mouseMoved(ofMouseEventArgs &);

    void mouseDragged(ofMouseEventArgs &);

    void mousePressed(ofMouseEventArgs &);

    void mouseReleased(ofMouseEventArgs &);

    void mouseScrolled(ofMouseEventArgs &);

    void mouseEntered(ofMouseEventArgs &);

    void mouseExited(ofMouseEventArgs &);

    void touchDown(ofTouchEventArgs &);

    void touchMoved(ofTouchEventArgs &);

    void touchUp(ofTouchEventArgs &);

    void touchDoubleTap(ofTouchEventArgs &);

    void touchCancelled(ofTouchEventArgs &);

    void windowResized(ofResizeEventArgs &);

    void dragged(ofDragInfo &);

    void messageReceived(ofMessage &);

    ofxImGui gui;

    ImVec4 backgroundColor;
    bool show_test_window;
    bool show_another_window;

    float floatValue;
    int intValue;

    ofImage imageButtonSource;
    GLuint imageButtonID;

    ofPixels pixelsButtonSource;
    GLuint pixelsButtonID;

    ofTexture textureSource;
    GLuint textureSourceID;

    ofxAssimpModelLoader model;
    ofLight light;
    int lightPosArray[3]={100,100,100};
    ofMaterial mat;

    // stores the info on the current file.
    string curFileInfo;

    //boolean to toggle help text
    bool bHelpText;
  
    // for demonstrating loading in models directly into a mesh without using ofxAssimpModelLoader
    ofVboMesh mesh;
    bool bUsingMesh;
    ofEasyCam cam;

    float bgColor[3]={133/255.0,150/255.0,220/255.0};
    ofImage snapshot;
  Eigen::MatrixXf V,N;
  Eigen::MatrixXi F;
  ofVbo vbo;
  ofImage testshot;
    SERIALIZE_BEGIN
        //SERIALIZE()
    SERIALIZE_END

};
