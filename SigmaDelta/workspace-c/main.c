#include <stdint.h>
#include <stdio.h>

//Defines for the width of the Sigma Delta Modulator
#define SIGMA_DELTA_BITS 12
#define SIGMA_DELTA_MAX_VALUE ((1<<SIGMA_DELTA_BITS) - 1)
#define SIGMA_DELTA_MIN_VALUE 0
#define SIGMA_DELTA_THRESHOLD (1<<(SIGMA_DELTA_BITS - 1))

//Struct of the 2nd order Sigma Delta Modulator
struct SigmaDelta2
{
    int32_t integrator0;
    int32_t integrator1;
    uint8_t output;
};

//Function to calculate the output of the 2nd order Sigma Delta Modulator
uint8_t CalculateSigmaDeltaValue(struct SigmaDelta2* sdm, uint16_t input)
{
    //Calculating the feedback based on the previous output
    uint16_t feedback = (sdm->output == 1) ? SIGMA_DELTA_MAX_VALUE : SIGMA_DELTA_MIN_VALUE;

    //Calculating the new values of the first and second integrator
    sdm->integrator0 = sdm->integrator0 - feedback + input;
    sdm->integrator1 = sdm->integrator1 - feedback + sdm->integrator0;

    //Calculating the output
    sdm->output = (sdm->integrator1 >= SIGMA_DELTA_THRESHOLD) ? 1 : 0;

    //Returning the output
    return sdm->output;
}



#define BUFFER_LENGTH 65000
uint8_t sigmaDeltaBuffer[BUFFER_LENGTH];

void CleanSigmaDeltaBuffer(uint8_t buffer[], uint16_t length)
{
    for(uint16_t i = 0; i<length; i++)
    {
        buffer[i] = 0;
    }
}



struct SigmaDelta2 sd2;

int main()
{
    sd2.integrator0 = 0;
    sd2.integrator1 = 0;
    sd2.output = 0;

    CleanSigmaDeltaBuffer(sigmaDeltaBuffer, BUFFER_LENGTH);

    for(int i = 0; i < BUFFER_LENGTH; i++)
    {
        sigmaDeltaBuffer[i] = CalculateSigmaDeltaValue(&sd2, 2222);
    }

    float avg = 0;
    for(int i = 0; i < BUFFER_LENGTH; i++)
    {
        avg += sigmaDeltaBuffer[i];
    }
    avg = (avg / BUFFER_LENGTH)*SIGMA_DELTA_MAX_VALUE;
    
    printf("Average value of the output: %.3f\n", avg);
    return 0;
}