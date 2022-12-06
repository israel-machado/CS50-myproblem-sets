#include <stdio.h>
#include <cs50.h>
#include <math.h>

int main(void)

{
    long cardNumber;
    int sum1 = 0, sum2 = 0, num = 0, remainder = 0;

    // Credit card number input by user

    do
    {
        cardNumber = get_long("Insert your Credit Card number: ");

    }
    while (cardNumber <= 0);

    //Luhn's Algorithm

    long forLuhn = cardNumber;

    while (forLuhn > 0)
    {
        num = ((forLuhn / 10) % 10) * 2; // Multiplying every other digit by 2, starting with the number’s second-to-last digit
        while (num > 0)
        {
            remainder = num % 10;
            sum1 += remainder; // Adding those products’ digits together
            num /= 10;
        }
        forLuhn /= 100;
    }

    // So as to restore the initial values of remainder and temp for the use in next loop
    remainder = 0;
    forLuhn = cardNumber;

    while (forLuhn > 0)
    {
        remainder = forLuhn % 10;
        sum2 += remainder; // Sum of the digits that weren’t multiplied by 2
        forLuhn /= 100;
    }

    if (((sum1 + sum2) % 10) != 0)
    {
        printf("INVALID\n");
    }
    else
    {
        // Check if it is a AmericanExpress/MasterCard/Visa
        // AMEX = 15 digits, starts with 34 or 37;
        // MasterCard = 16 digits, starts with 51, 52, 53, 54 or 55;
        // Visa = 13 or 16 digits, starts with 4;

        long checkFlag = cardNumber;
        long checkFlag2 = cardNumber;


        while (checkFlag >= 100)
        {
            checkFlag /= 10;
        }
        while (checkFlag2 >= 10)
        {
            checkFlag2 /= 10;

        }

        //AMEX

        if ((cardNumber < 1000000000000000 && cardNumber > 99999999999999) && (checkFlag == 34 || checkFlag == 37))
        {
            printf("AMEX\n");
        }

        //MasterCard

        else if ((cardNumber < 10000000000000000 && cardNumber > 999999999999999) && (checkFlag == 51 || checkFlag == 52 || checkFlag == 53
                 || checkFlag == 54 || checkFlag == 55))
        {
            printf("MASTERCARD\n");
        }

        //Visa

        else if (((cardNumber < 10000000000000000 && cardNumber > 999999999999999) || (cardNumber > 999999999999
                  && cardNumber < 10000000000000)) && (checkFlag2 == 4))
        {
            printf("VISA\n");
        }
        else
        {
            printf("INVALID\n");
        }
    }
}