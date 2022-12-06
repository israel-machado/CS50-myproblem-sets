#include <math.h>
#include <ctype.h>
#include <cs50.h>
#include <string.h>
#include <stdio.h>

int count_letters(string text);
int count_words(string text);
int count_sentences(string text);

//Main
int main(void)
{
    string text = get_string("Text: ");
    float letters = count_letters(text);
    float words = count_words(text);
    float sentences = count_sentences(text);

    //Coleman-Liau index
    float averageLetters = (letters * 100) / words;
    float averageSentences = (sentences * 100) / words;

    int index = round(((0.0588 * averageLetters) - (0.296 * averageSentences)) - 15.8);

    if (index >= 16)
    {
        printf("Grade 16+\n");
    }
    else if (index < 1)
    {
        printf("Before Grade 1\n");
    }
    else
    {
        printf("Grade %i\n", index);
    }

}

// Function to count how many letter in the string
int count_letters(string text)
{
    int lenght = strlen(text);
    int count = 0;

    for (int i = 0; i < lenght; i++)
        if (isalpha(text[i]))
        count++;

    return count;
}

// Function to count how many words in the string
int count_words(string text)
{
    int lenght = strlen(text);
    int count = 0;

    for (int i = 0; i < lenght; i++)
        if(text[i] == 32)
        count++;

    return count + 1;
}

// Function to count how many sentences in the string
int count_sentences(string text)
{
    int lenght = strlen(text);
    int count = 0;

    for (int i = 0; i < lenght; i++)
        if (text[i] == '.' || text[i] == '?' || text[i] == '!')
        count++;

    return count;

}
