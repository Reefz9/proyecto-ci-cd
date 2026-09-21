package com.ejemplo;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class AppTest {

    @Test
    void debeSumarDosNumeros() {
        App app = new App();

        int resultado = app.sumar(2, 3);

        assertEquals(5, resultado);
    }
}