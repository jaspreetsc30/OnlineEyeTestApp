//
// Created by Jaspreet on 15/4/2022.
//

#include <main.cpp>
#include <iostream>
#include <opencv2/opencv.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/objdetect.hpp>
#include <opencv2/core/types.hpp>
#include <string>
#include <limits.h>
#include <unistd.h>




using namespace cv;
using namespace std;

//constants
double Known_distance = 17 ; // Inches
double Known_width = 5.78f ;  // Inches
double checker = 1.11f;


void rotateMat(Mat &matImage, int rotation)
{
    if (rotation == 90) {
        transpose(matImage, matImage);
        flip(matImage, matImage, 1); //transpose+flip(1)=CW
    } else if (rotation == 270) {
        transpose(matImage, matImage);
        flip(matImage, matImage, 0); //transpose+flip(0)=CCW
    } else if (rotation == 180) {
        flip(matImage, matImage, -1);    //flip(-1)=180
    }
}




int checkstuff(const char* path){
    CascadeClassifier faceDetectorobj;
    String xmlfile(path) ;
    if (!faceDetectorobj.load(xmlfile)){

        return -1;
    };

    return 100;

}


double FocalLength(double measured_distance , double real_width , int width_in_rf_image){
    return (width_in_rf_image * measured_distance) / real_width;
}


double DistanceFinder(double Focal_Length, double real_face_width, int face_width_in_frame ){
    return (real_face_width * Focal_Length) / face_width_in_frame;
}

void faceDetector(Mat &src , bool callOut , int distanceLevel , vector<Rect> &faces , int  &width,CascadeClassifier& faceDetector ){
    //convert src to grey
    Mat gray;
    cvtColor(src,gray, COLOR_BGR2GRAY );


    faceDetector.detectMultiScale(gray,faces,1.3,5);
    int lineThickness = 2 ;
    for( vector<Rect>::const_iterator r = faces.begin(); r != faces.end(); ++r ){

        if (distanceLevel < 10)
            distanceLevel = 10;

        width = r->width;

    }


}




int main()
{

    Mat src;
    VideoCapture cap(0);
    // https://docs.opencv.org/3.4/d4/d15/group__videoio__flags__base.html#ga023786be1ee68a9105bf2e48c700294d need to change for android
    int distance_level = 0;

    // get one frame from camera to know frame size and type
    cap >> src;
    Mat cappedsrc = src;
    // check if we succeeded
    if (src.empty()) {
        cout << "ERROR! blank frame grabbed\n";
        return -3;
    }


    CascadeClassifier faceDetectorobj;
    String xmlfile = "C:/Users/Jaspreet/Desktop/cppversion/haarcascade_frontalface_default.xml" ;
    if (!faceDetectorobj.load(xmlfile)){
        cout<<"could not load" ;
        return -2;
    };

    //check that face detection works
    imshow("capped image",src);


    vector<Rect> faces;
    int faceWidth = 0;
    faceDetector(src , false , 0 , faces , faceWidth, faceDetectorobj);
    double computedFocalLength = FocalLength(Known_distance , Known_width , faceWidth);


        // Mat newsrc;
        cap.read(src);

        faceDetector(src , true , 0 , faces , faceWidth, faceDetectorobj);
        double distance ;

        for( vector<Rect>::const_iterator r = faces.begin(); r != faces.end(); ++r ){
            if (computedFocalLength != 0){
                distance = DistanceFinder(computedFocalLength,Known_width, faceWidth);

            }
        }
        return distance ;

}


extern "C" {
    //prevent unused function from being removed and make it visible
    __attribute__((visibility("default"))) __attribute__((used))
    const char* version(){
        return CV_VERSION;
    }

    __attribute__((visibility("default"))) __attribute__((used))
    int mainf(){

        return main() ;
    }

    __attribute__((visibility("default"))) __attribute__((used))
    int getmessage(const char* path){

        return checkstuff(path);

    }

    __attribute__((visibility("default"))) __attribute__((used))
    double refimage(int width , int height , int rotation , uint8_t* bytes, int isYUV, const char* path){
        //create frame
        Mat frame;
        if (isYUV == 1) {
            Mat myyuv(height + height / 2, width, CV_8UC1, bytes);
            cvtColor(myyuv, frame, COLOR_YUV2BGRA_NV21);
        } else {
            frame = Mat(height, width, CV_8UC4, bytes);
        }

        rotateMat(frame, rotation);



        //load xml
        String xmlfilepath(path);
        CascadeClassifier faceDetectorobj;

        if (!faceDetectorobj.load(xmlfilepath)){
            return -1;
        };

        vector<Rect> faces;
        int faceWidth = 0;
        faceDetector(frame , false , 0 , faces , faceWidth, faceDetectorobj);
        double computedFocalLength = FocalLength(Known_distance , Known_width , faceWidth);

        return computedFocalLength ;

    }

    __attribute__((visibility("default"))) __attribute__((used))
    double getdistance(int width , int height , int rotation , uint8_t* bytes, int isYUV, const char* path , double computedFocalLength){
        //create frame
        Mat frame;
        if (isYUV == 1) {
            Mat myyuv(height + height / 2, width, CV_8UC1, bytes);
            cvtColor(myyuv, frame, COLOR_YUV2BGRA_NV21);
        } else {
            frame = Mat(height, width, CV_8UC4, bytes);
        }


        rotateMat(frame, rotation);

        //load xml
        String xmlfilepath(path);
        CascadeClassifier faceDetectorobj;

        if (!faceDetectorobj.load(xmlfilepath)){
            return -1;
        };
        vector<Rect> faces;
        int faceWidth = 0;
        faceDetector(frame , true , 0 , faces , faceWidth, faceDetectorobj);

        double distance;
        for( vector<Rect>::const_iterator r = faces.begin(); r != faces.end(); ++r ){
            if (computedFocalLength != 0){

                distance = DistanceFinder(computedFocalLength,Known_width, faceWidth);
                cout<<distance<<endl ;

            }
        }
        return distance ;


    }






}