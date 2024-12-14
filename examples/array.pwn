#include"a_samp"

main() {
    new arrays[5];

    for (new j = 0; j < 1000; j++) {
        arrays[0] = 100;
        arrays[1] = 200;
        arrays[2] = 300;
        arrays[3] = 400;
        arrays[4] = 500;

        printf "Iteration %d:", j + 1;
        for (new i = 0; i < sizeof(arrays); i++) {
            printf "arrays[%d] = %d", i, arrays[i];
        }
    }
}
