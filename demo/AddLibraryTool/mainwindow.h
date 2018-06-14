﻿#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <qqtdictionary.h>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow ( QWidget* parent = 0 );
    ~MainWindow();

    void calculate ( QQtDictionary& dict, QString path );
    //void calculateLib ( QQtDictionary& dict, QString path );

private:

private slots:
    void on_pushButton_clicked();

private:
    Ui::MainWindow* ui;
};

#endif // MAINWINDOW_H
