#include "statusmovimentacaoenum.h"
#include <QQmlApplicationEngine>

void StatusMovimentacaoEnum::init()
{
    qRegisterMetaType<StatusMovimentacaoEnum::StatusMovimentacao>("StatusMovimentacaoEnum::StatusMovimentacao");
    qmlRegisterType<StatusMovimentacaoEnum>("MyQmlModule", 1, 0, "StatusMovimentacaoEnum");
}
