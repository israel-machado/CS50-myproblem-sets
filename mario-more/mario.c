#include <cs50.h>
#include <stdio.h>

int main(void)
{
    int height;
    do
    {
        height = get_int("Height: ");
    }
    while (height > 8 || height <= 0);

    // Print made

    // Left Side
    for (int row = 0; row < height; row++)
    {
        for (int collum = 0; collum < height; collum++)
        {
            if (collum < height - row - 1)
            {
                printf(" ");
            }
            else
            {
                printf("#");
            }
        }

        printf("  "); // Space between sides

    // Right side
        for (int collum = 0; collum < row + 1; collum++)
        {
            printf("#");
        }

        printf("\n");
    }
}