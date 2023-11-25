#include <math.h>
#include <stdio.h>
#include <stdlib.h>

// extern void imgAvgFilter(int *input_image, int *filtered_image, int
// image_size_x,int image_size_y, int sampling_window_size)

// To be translated into SASM
void imgAvgFilter(int *input_image, int *filtered_image, int image_size_x,
                  int image_size_y, int sampling_window_size) {

  double divisor = sampling_window_size * sampling_window_size;

  for (int i = 0; i < image_size_x; i++) {
    for (int j = 0; j < image_size_y; j++) {
      if (i > 0 && i < image_size_x - 1 && j > 0 && j < image_size_y - 1) {

        double sum = 0;

        for (int m = -1; m <= 1; m++) {
          for (int n = -1; n <= 1; n++) {
            sum += input_image[(i + m) * image_size_y + (j + n)];
          }
        }

        // Calculate the average and store it in the filtered image
        filtered_image[i * image_size_y + j] = round(sum / divisor);

      } else {
        filtered_image[i * image_size_y + j] =
            input_image[i * image_size_y + j];
      }
    }
  }
}

int main() {

  int image_size_x, image_size_y;
  int sampling_window_size;

  printf("Input image size (x): ");
  scanf("%d", &image_size_x);

  printf("Input image size (y): ");
  scanf("%d", &image_size_y);

  printf("Input window size: ");
  scanf("%d", &sampling_window_size);

  int *input_image = malloc((image_size_x) * (image_size_y) * sizeof(int));
  int *filtered_image = malloc((image_size_x) * (image_size_y) * sizeof(int));

  printf("Input elements for the image:\n");

  for (int i = 0; i < image_size_x; i++) {
    for (int j = 0; j < image_size_y; j++) {
      scanf("%d", &input_image[i * image_size_y + j]);
    }
  }

  imgAvgFilter(input_image, filtered_image, image_size_x, image_size_y,
               sampling_window_size);

  // Display the input image
  printf("\nInput Image:\n");
  for (int i = 0; i < image_size_x; i++) {
    for (int j = 0; j < image_size_y; j++) {
      printf("%d ", input_image[i * image_size_y + j]);
    }
    printf("\n");
  }

  // Display filtered image
  printf("\nFiltered Image:\n");
  for (int i = 0; i < image_size_x; i++) {
    for (int j = 0; j < image_size_y; j++) {
      printf("%d ", filtered_image[i * image_size_y + j]);
    }
    printf("\n");
  }

  free(input_image);
  free(filtered_image);

  return 0;
}