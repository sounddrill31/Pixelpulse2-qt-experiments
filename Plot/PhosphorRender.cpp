#include "PhosphorRender.h"

PhosphorRender::PhosphorRender(QQuickItem *parent)
    : QQuickItem(parent)
{
    setFlag(ItemHasContents, true);
}

PhosphorRender::~PhosphorRender()
{
    // Cleanup handled by Qt's object destruction
}

void PhosphorRender::setXmin(double xmin)
{
    if (m_xmin == xmin) return;
    m_xmin = xmin;
    emit xminChanged(xmin);
    update();
}

void PhosphorRender::setXmax(double xmax)
{
    if (m_xmax == xmax) return;
    m_xmax = xmax;
    emit xmaxChanged(xmax);
    update();
}

void PhosphorRender::setYmin(double ymin)
{
    if (m_ymin == ymin) return;
    m_ymin = ymin;
    emit yminChanged(ymin);
    update();
}

void PhosphorRender::setYmax(double ymax)
{
    if (m_ymax == ymax) return;
    m_ymax = ymax;
    emit ymaxChanged(ymax);
    update();
}

void PhosphorRender::setPointSize(double pointSize)
{
    if (m_pointSize == pointSize) return;
    m_pointSize = pointSize;
    emit pointSizeChanged(pointSize);
    update();
}

void PhosphorRender::setColor(QColor color)
{
    if (m_color == color) return;
    m_color = color;
    emit colorChanged(color);
    update();
}
