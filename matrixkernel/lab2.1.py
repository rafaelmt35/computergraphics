import numpy as np
import cv2

# Load image
image = cv2.imread('test1.png')

#3x3 kernel

#identity kernel Исходное изображение
# kernel = np.array([[0, 0, 0],
#  [0, 1, 0],
#  [0, 0, 0]], dtype=np.float32)

#box blur kernel Размывание
# kernel = np.array([[1, 1, 1],
#  [1, 1, 1],
#  [1, 1, 1]], dtype=np.float32)

# [[0, 1, 0],
#  [1,  4, 1],
#  [0, 1, 0]]

# [[1, 2, 1],
#  [2,  4, 2],
#  [1, 2, 1]]


#sharpen Увеличение резкости, подчеркивание границ 
# kernel = np.array([[-1,-1,-1],
#  [-1, 9, -1],
#  [-1,-1,-1]], dtype=np.float32)


#edge detection (Нахождение границ)
kernel = np.array([[0,1,0],
 [1,  -4, 1],
 [0,1,0]], dtype=np.float32)

# [[0,-1,0],
#  [-1,4,-1],
#  [0,-1,0]]


# emboss Тиснение
# kernel = np.array([[0, 1, 0],
#                   [1, 0, -1],
#                   [0, -1, 0]], dtype=np.float32)


# Perform convolution using the filter2D function
output_image = cv2.filter2D(image, -1, kernel)
# The -1 parameter in cv2.filter2D indicates that the output image will have the same depth (number of color channels) as the input image

# Display the original and convolved images
cv2.imshow('Original Image', image)
cv2.imshow('Output Image', output_image)
cv2.waitKey(0)
cv2.destroyAllWindows()
