#ifndef APIWRAPPER_H
#define APIWRAPPER_H

#include <QObject>

class ApiWrapper : public QObject
{
    Q_OBJECT
public:
    explicit ApiWrapper (QObject* parent = 0) : QObject(parent) {}
    Q_INVOKABLE void setTimerDisabled();
    Q_INVOKABLE void setTimerEnabled();
};

#endif // APIWRAPPER_H
