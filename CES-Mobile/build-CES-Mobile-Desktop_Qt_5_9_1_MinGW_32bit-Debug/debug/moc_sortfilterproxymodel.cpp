/****************************************************************************
** Meta object code from reading C++ file 'sortfilterproxymodel.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.9.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../CES-Mobile/sortfilterproxymodel.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'sortfilterproxymodel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.9.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_SortFilterProxyModel_t {
    QByteArrayData data[18];
    char stringdata0[178];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_SortFilterProxyModel_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_SortFilterProxyModel_t qt_meta_stringdata_SortFilterProxyModel = {
    {
QT_MOC_LITERAL(0, 0, 20), // "SortFilterProxyModel"
QT_MOC_LITERAL(1, 21, 12), // "countChanged"
QT_MOC_LITERAL(2, 34, 0), // ""
QT_MOC_LITERAL(3, 35, 3), // "get"
QT_MOC_LITERAL(4, 39, 8), // "QJSValue"
QT_MOC_LITERAL(5, 48, 5), // "index"
QT_MOC_LITERAL(6, 54, 5), // "count"
QT_MOC_LITERAL(7, 60, 6), // "source"
QT_MOC_LITERAL(8, 67, 8), // "sortRole"
QT_MOC_LITERAL(9, 76, 9), // "sortOrder"
QT_MOC_LITERAL(10, 86, 13), // "Qt::SortOrder"
QT_MOC_LITERAL(11, 100, 10), // "filterRole"
QT_MOC_LITERAL(12, 111, 12), // "filterString"
QT_MOC_LITERAL(13, 124, 12), // "filterSyntax"
QT_MOC_LITERAL(14, 137, 12), // "FilterSyntax"
QT_MOC_LITERAL(15, 150, 6), // "RegExp"
QT_MOC_LITERAL(16, 157, 8), // "Wildcard"
QT_MOC_LITERAL(17, 166, 11) // "FixedString"

    },
    "SortFilterProxyModel\0countChanged\0\0"
    "get\0QJSValue\0index\0count\0source\0"
    "sortRole\0sortOrder\0Qt::SortOrder\0"
    "filterRole\0filterString\0filterSyntax\0"
    "FilterSyntax\0RegExp\0Wildcard\0FixedString"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_SortFilterProxyModel[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       7,   28, // properties
       1,   56, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   24,    2, 0x06 /* Public */,

 // methods: name, argc, parameters, tag, flags
       3,    1,   25,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,

 // methods: parameters
    0x80000000 | 4, QMetaType::Int,    5,

 // properties: name, type, flags
       6, QMetaType::Int, 0x00495001,
       7, QMetaType::QObjectStar, 0x00095103,
       8, QMetaType::QByteArray, 0x00095103,
       9, 0x80000000 | 10, 0x0009510b,
      11, QMetaType::QByteArray, 0x00095103,
      12, QMetaType::QString, 0x00095103,
      13, 0x80000000 | 14, 0x0009510b,

 // properties: notify_signal_id
       0,
       0,
       0,
       0,
       0,
       0,
       0,

 // enums: name, flags, count, data
      14, 0x0,    3,   60,

 // enum data: key, value
      15, uint(SortFilterProxyModel::RegExp),
      16, uint(SortFilterProxyModel::Wildcard),
      17, uint(SortFilterProxyModel::FixedString),

       0        // eod
};

void SortFilterProxyModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        SortFilterProxyModel *_t = static_cast<SortFilterProxyModel *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->countChanged(); break;
        case 1: { QJSValue _r = _t->get((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJSValue*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (SortFilterProxyModel::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&SortFilterProxyModel::countChanged)) {
                *result = 0;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        SortFilterProxyModel *_t = static_cast<SortFilterProxyModel *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = _t->count(); break;
        case 1: *reinterpret_cast< QObject**>(_v) = _t->source(); break;
        case 2: *reinterpret_cast< QByteArray*>(_v) = _t->sortRole(); break;
        case 3: *reinterpret_cast< Qt::SortOrder*>(_v) = _t->sortOrder(); break;
        case 4: *reinterpret_cast< QByteArray*>(_v) = _t->filterRole(); break;
        case 5: *reinterpret_cast< QString*>(_v) = _t->filterString(); break;
        case 6: *reinterpret_cast< FilterSyntax*>(_v) = _t->filterSyntax(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        SortFilterProxyModel *_t = static_cast<SortFilterProxyModel *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 1: _t->setSource(*reinterpret_cast< QObject**>(_v)); break;
        case 2: _t->setSortRole(*reinterpret_cast< QByteArray*>(_v)); break;
        case 3: _t->setSortOrder(*reinterpret_cast< Qt::SortOrder*>(_v)); break;
        case 4: _t->setFilterRole(*reinterpret_cast< QByteArray*>(_v)); break;
        case 5: _t->setFilterString(*reinterpret_cast< QString*>(_v)); break;
        case 6: _t->setFilterSyntax(*reinterpret_cast< FilterSyntax*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject SortFilterProxyModel::staticMetaObject = {
    { &QSortFilterProxyModel::staticMetaObject, qt_meta_stringdata_SortFilterProxyModel.data,
      qt_meta_data_SortFilterProxyModel,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *SortFilterProxyModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *SortFilterProxyModel::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_SortFilterProxyModel.stringdata0))
        return static_cast<void*>(const_cast< SortFilterProxyModel*>(this));
    return QSortFilterProxyModel::qt_metacast(_clname);
}

int SortFilterProxyModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QSortFilterProxyModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 2)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 2;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 7;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void SortFilterProxyModel::countChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
