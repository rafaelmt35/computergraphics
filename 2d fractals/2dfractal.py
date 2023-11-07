import turtle

# L-system rules and axiom
axiom = "S"

## RULES cтр 42-45 главы 5-8
# Снежинка Коха. it=4 // angle = 60
# rules = {
#     "S": "F++F++F",
#     "F": "F-F++F-F",
# }

# Дракон Хартера-Хатвея it=14// angle =90
# rules = {
#     "S":"FX",
#     "F" :"F",
#     "X" : "X+YF+",
#     "Y":"-FX-Y"
# }

# Треугольник Серпинского. it=6//angle =60
# rules = {
#     "S": "FXF-FF-FF",
#     "F": "FF",
#     "X": "-FXF++FXF++FXF--"
# }

# Кривая Гильберта. it=6 //angle=90
# rules = {
#     "S":"X",
#     "F":"F",
#     "X":"-YF+XFX+FY-",
#     "Y":"+XF-YFY-FX+"
# }

# Дерево 1. it= 5//angle = 25.7
# rules = {
#     "S":"F",
#     "F":"F[+F]F[-F]F"
# }

# Дерево 2. it= 5 // angle=20
# rules = {
#     "S":"F",
#     "F":"F[+F]F[-F][F]"
# }

# Дерево 3.  it= 5 // angle=25.7
# rules = {
#     "S": "X",
#     "F": "FF",
#     "X":"F[+X][-X]FX"
# }

# Дерево 4.  it= 5 // angle=20
rules = {
    "S": "F",
    "F": "-F[-F+F-F]+[+F-F-F]"
}


# Generate L-system string
it = 5
angle = 20  # Angle
current_string = axiom
next_string = ""
for _ in range(it):
    for char in current_string:
        next_string += rules.get(char, char)
    current_string = next_string
    next_string = ""



# FOR without stack[] 
# L-system string using Turtle Graphics
# turtle.speed(0)
# for char in current_string:
#     if char == "F":
#         turtle.forward(5)
#     elif char == "+":
#         turtle.right(angle)
#     elif char == "-":
#         turtle.left(angle)

# FOR TREE
turtle.speed(0)
turtle.setheading(0)
stack = []

for char in current_string:
    if char == "F":
        turtle.forward(20)
    elif char == "+":
        turtle.right(angle)
    elif char == "-":
        turtle.left(angle)
    elif char == "[":
        stack.append((turtle.position(), turtle.heading()))
    elif char == "]":
        position, heading = stack.pop()
        turtle.penup()
        turtle.setposition(position)
        turtle.setheading(heading)
        turtle.pendown()

turtle.done()
