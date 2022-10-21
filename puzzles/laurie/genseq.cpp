#include <list>

#include <iostream>

int main() {

    for (size_t a = 1; a <= 6; a++)
    {
        for (size_t b = 1; b <= 6; b++)
        {
            for (size_t c = 1; c <= 6; c++)
            {
                for (size_t d = 1; d <= 6; d++)
                {
                    for (size_t e = 1; e <= 6; e++)
                    {
                        std::cout << 4 << " " << a << " " << b << " " << c << " " << d << " " << e << std::endl;   
                    }
                }
            }   
        }
    }
    return 0;
}