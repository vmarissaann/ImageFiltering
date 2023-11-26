#include <stdio.h>
#include <windows.h>

 extern void imgAvgFilter(int* input_image, int* filtered_image, int image_size_x,int image_size_y, int sampling_window_size);

int main(){
	//Goal send array to sasm file
	//return same array to C
	//do the average and sum print thing
	
	// Initializing variables
	int image_size_x, image_size_y;
	int sampling_window_size;
	int* input_image;
	int* filtered_image;
	int i, j; //counters
	
	// Input image size of x
	printf("Input image size (x): ");
	scanf("%d", &image_size_x);
	
	// Input image size of y
	printf("Input image size (y): ");
	scanf("%d", &image_size_y);
	
	// Input window size
	printf("Input window size: ");
	scanf("%d", &sampling_window_size);
	
	//Allocating memory space for input image and filtered image to be passed in the SASM file
	input_image = (int*)malloc(image_size_x * image_size_y * sizeof(int));
	filtered_image = (int*) malloc(image_size_x * image_size_y * sizeof(int));
	
	// Input elements of image
	printf("Input elements for the image:\n");
	for (i=0; i < image_size_x; i++) {
		for (j = 0; j < image_size_y; j++) {
			scanf("%d", &input_image[i * image_size_y + j]);
		}
	}
	
	//calls the imAvgFilter in SASM
	imgAvgFilter(input_image, filtered_image, image_size_x, image_size_y, sampling_window_size);
	
	// TO DO for testing only: equate input image with filtered image such that to show sasm is working
	 // Display the input image
	  printf("\nInput Image:\n");
	  for (i = 0; i < image_size_x; i++) {
		for (j = 0; j < image_size_y; j++) {
		  printf("%d ", input_image[i * image_size_y + j]);
		}
		printf("\n");
	  }
	  
	// Display filtered image
	printf("\nFiltered Image:\n");
	for (i = 0; i < image_size_x; i++) {
		for (j = 0; j < image_size_y; j++) {
		printf("%d ", filtered_image[i * image_size_y + j]);
		}
		printf("\n");
	}
	
}