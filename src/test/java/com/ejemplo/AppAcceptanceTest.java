package com.ejemplo;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class AppAcceptanceTest {

    @Test
    void debeCumplirElComportamientoEsperadoPorElUsuario() {
        App app = new App();

        int resultado = app.sumar(10, 20);

        assertEquals(30, resultado);
    }
}