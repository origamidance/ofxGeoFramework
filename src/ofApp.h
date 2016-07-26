#pragma once

#include "ofLiveMain.h"
#include "ofxImGui.h"
#include "ThemeTest.h"
#include "ofxAssimpModelLoader.h"

#define RED(x) "\033[31m" << x << "\033[0m"

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

    // stores the info on the current file.
    string curFileInfo;

    //boolean to toggle help text
    bool bHelpText;

    // for demonstrating loading in models directly into a mesh without using ofxAssimpModelLoader
    ofVboMesh mesh;
    bool bUsingMesh;
    ofEasyCam cam;


    SERIALIZE_BEGIN
        //SERIALIZE()
    SERIALIZE_END

};
