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
float Known_distance = 17 ; // Inches
float Known_width = 5.78f ;  // Inches
float checker = 1.11f;


int checkstuff(){
    CascadeClassifier faceDetectorobj;
    String xmlfile = "C:/Users/Jaspreet/Desktop/FYP/application/opencvplugin/ios/Classes/haarcascade_frontalface_default.xml" ;
    if (!faceDetectorobj.load(xmlfile)){

        return -1;
    };

    return 100;

}

const char * getexepath()
{
    char result[ PATH_MAX ];
    ssize_t count = readlink( "/proc/self/exe", result, PATH_MAX );
    String  path =string( result, (count > 0) ? count : 0 );
    const char * c = path.c_str();
    return c;

}


float FocalLength(float measured_distance , float real_width , int width_in_rf_image){
    return (width_in_rf_image * measured_distance) / real_width;
}


float DistanceFinder(float Focal_Length, float real_face_width, int face_width_in_frame ){
    return (real_face_width * Focal_Length) / face_width_in_frame;
}

void faceDetector(Mat &src , bool callOut , int distanceLevel , vector<Rect> &faces , int  &width,CascadeClassifier& faceDetector ){
    //convert src to grey
    Mat gray;
    cvtColor(src,gray, COLOR_BGR2GRAY );


    faceDetector.detectMultiScale(gray,faces,1.3,5);
    int lineThickness = 2 ;
    for( vector<Rect>::const_iterator r = faces.begin(); r != faces.end(); ++r ){
        int LLV = (int) (r->height * 0.12) ;

        line(src, Point(r->x, r->y + LLV), Point(r->x + r->width, r->y + LLV), Scalar(255,255,255), lineThickness) ;
        line(src, Point(r->x, r->y + r->height), Point(r->x + r->width, r->y + r->height),Scalar(255,255,255), lineThickness);
        line(src, Point(r->x + r->width, r->y + LLV), Point(r->x + r->width, r->y + r->height), Scalar(255,255,255), lineThickness);
        line(src, Point(r->x, r->y + r->height), Point(r->x, r->y +  LLV),Scalar(255,255,255), lineThickness);

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
    float computedFocalLength = FocalLength(Known_distance , Known_width , faceWidth);
    cout<<computedFocalLength<<endl<<endl<<endl<<endl<<endl;
    cout<<faceWidth<<endl<<endl<<endl<<endl<<endl;









        // Mat newsrc;
        cap.read(src);

        faceDetector(src , true , 0 , faces , faceWidth, faceDetectorobj);


        for( vector<Rect>::const_iterator r = faces.begin(); r != faces.end(); ++r ){
            if (computedFocalLength != 0){

                float distance = DistanceFinder(computedFocalLength,Known_width, faceWidth);
                return distance ;
                cout<<distance<<endl ;
                string message = to_string(distance) + " Inches" ;
                putText(src ,
                        message ,
                        Point(r->x - 6, r->y - 6),
                        FONT_HERSHEY_SIMPLEX,
                        1,
                        (255,255,255),
                        2,
                        LINE_AA);
            }
        }
        if (src.empty()) {
            cout << "ERROR! blank frame grabbed\n";
            return -1;
        }
        imshow("Distance",src);
        waitKey(1);










    // cap.release();
    // destroyAllWindows();






    cout<<"build works";
    cout<<"ok";
    return -1;
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
    int getmessage(){
        return checkstuff();

    }





}