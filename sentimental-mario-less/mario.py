import cs50

height = 0

# Loop to validate the value of Height
while height > 8 or height < 1:
    height = cs50.get_int("Height: ")

#Pyramid
for i in range(height):
    for j in range(height):
        if j < (height - i - 1):
            print(" ", end='')
        else:
            print("#", end='')
    print()

