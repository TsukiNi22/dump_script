/*
** EPITECH PROJECT, 2025
** math.h
** File description:
** Header for all thing who have a link with math
*/

#ifndef MATH_H
    #define MATH_H

    //----------------------------------------------------------------//
    /* DEFINE */

    /* math */
    #define PI 3.14159265358979323846
    #define EULER 2.7182818284590452354
    #define LN_2 0.6931471805599453094
    #define H_ZERO (my_pow(10, -7))
    #define ACCURACY 1000

//----------------------------------------------------------------//
/* PROTOTYPE */

/* math_gestion */
int find_prime_sup(int nb); // Error: None

/* math_comparaison */
int is_prime(int nb); // Error: KO

/* math_operator */
long double my_pow(double x, double pow); // Error: None
float my_sqrt(float x); // Error: None
double my_gamma(float x); // Error: 0
double my_factorial(int x); // Error: KO
int my_binomial(float n, float k); // Error: -1

/* math_function */
float my_round(float x, int precision); // Error: None
long double my_log(double base, double x); // Error: inf (div by 0)
long double my_exp(double pow); // Error: None
long double my_ln(double x); // Error: None

/* math_trigonometrie */
float my_sin(float x); // Error: KO
float my_cos(float x); // Error: KO
double my_tan(float x); // Error: 0
float rad_degree(float x); // Error: None
float degree_rad(float x); // Error: None

#endif /* MATH_H */
