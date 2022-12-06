#include <cs50.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, string argv[])
{
    // Argument count limited to 2, including the ./caesar
    if (argc != 2)
    {
        printf("Usage: ./caesar key");
        return 1;
    }

    // Check if one of arguments is alphanumeric (Int needed)
    for (int key = 0; key < strlen(argv[1]); key++)
    {
        if (isalpha(argv[1][key]))
        {
            printf("Usage: ./caesar key\n");
            return 1;
        }
    }

    int k = atoi(argv[1]);  // Converting ASCII to a integer

    // Input from user
    string plainText = get_string("plaintext: ");

    printf("ciphertext: ");

    // Cipher-text

    for (int i = 0, n = strlen(plainText) ; i < n; i++)
        {
            // checking if it is lowercase 97 = a to 112 = z and if it + 13 characters along.
            if (plainText[i] >= 'a' && plainText[i] <= 'z')
            {
                printf("%c", (((plainText[i] - 'a') + k) % 26) + 'a'); // print out lowercase with key
            } // if it it between uppercase A and C
            else if (plainText[i] >= 'A' && plainText[i] <= 'Z')
            {
                printf("%c", (((plainText[i] - 'A') + k) % 26) + 'A'); // print out uppercase with key
            }
            else
            {
                printf("%c", plainText[i]);
            }
        }

        printf("\n");
        return 0;



}