import cv2
import numpy as np
import tkinter as tk
from tkinter import simpledialog

class ImageTransformerApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Image Transformer")

        self.src_image = cv2.imread('rotate.png')  # Load image
        self.src_points = []
        self.use_bilinear = True
        self.dots_set = False  # Flag to check if dots are set

        self.canvas = tk.Canvas(root, width=self.src_image.shape[1], height=self.src_image.shape[0])
        self.canvas.pack()
        self.photo = self.convert_cv2_image(self.src_image)
        self.image_id = self.canvas.create_image(0, 0, anchor=tk.NW, image=self.photo)
        self.canvas.bind("<Button-1>", self.add_point)

        self.bilinear_button = tk.Button(root, text="Bilinear", command=self.set_bilinear)
        self.simple_button = tk.Button(root, text="Simple", command=self.set_simple)
        self.clear_button = tk.Button(root, text="Clear Dots", command=self.clear_dots)

        self.bilinear_button.pack()
        self.simple_button.pack()
        self.clear_button.pack()


    # 3 точки на исходной картинке
    def add_point(self, event):
        x, y = event.x, event.y
        if len(self.src_points) < 3:
            self.src_points.append((x, y))
            self.canvas.create_oval(x - 3, y - 3, x + 3, y + 3, fill="red")
            if len(self.src_points) == 3:
                self.dots_set = True

    def set_bilinear(self):
        self.use_bilinear = True
        if self.dots_set:
            self.transform_image()

    def set_simple(self):
        self.use_bilinear = False
        if self.dots_set:
            self.transform_image()

    def clear_dots(self):
        self.src_points = []
        self.dots_set = False
        self.canvas.delete("all")
        self.photo = self.convert_cv2_image(self.src_image)
        self.image_id = self.canvas.create_image(0, 0, anchor=tk.NW, image=self.photo)

    def transform_image(self):
        if len(self.src_points) != 3:
            print("Please define three source points.")
            return

        matrix = cv2.getAffineTransform(np.float32(self.src_points), np.float32([(0, 0), (self.src_image.shape[1], 0), (0, self.src_image.shape[0])]))

        if self.use_bilinear:
            #билинейную фильтрацию 
            result = cv2.warpAffine(self.src_image, matrix, (self.src_image.shape[1], self.src_image.shape[0]), flags=cv2.INTER_LINEAR, borderMode=cv2.BORDER_REFLECT)
        else:
            #простейшего алгоритма
            result = cv2.warpAffine(self.src_image, matrix, (self.src_image.shape[1], self.src_image.shape[0]))

        self.canvas.delete(self.image_id)
        self.photo = self.convert_cv2_image(result)
        self.image_id = self.canvas.create_image(0, 0, anchor=tk.NW, image=self.photo)

    def convert_cv2_image(self, cv2_image):
        return tk.PhotoImage(data=cv2.imencode('.ppm', cv2_image)[1].tobytes())

root = tk.Tk()
app = ImageTransformerApp(root)
root.mainloop()
