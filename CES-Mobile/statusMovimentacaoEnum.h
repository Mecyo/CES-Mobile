#pragma once

#include <QObject>

class StatusMovimentacaoEnum : public QObject
{
    Q_OBJECT

public:
    enum class StatusMovimentacao {
        SOLICITADO_RETIRADA = 1,
        EMPRESTADO = 2,
        SOLICITADO_DEVOLUCAO = 3,
        DEVOLVIDO = 4,
        SOLICITADO_TRANSFERENCIA = 5,
        TRANSFERENCIA_PENDENTE = 6,
        TRANSFERENCIA_CONFIRMADA = 7,
        SOLICITADO_RESERVA = 8
    };
    Q_ENUM(StatusMovimentacao)

    static void init();
};
