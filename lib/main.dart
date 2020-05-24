import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ProportionsCalculator());
}

void removeFocus(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    currentFocus.focusedChild.unfocus();
  }
}

class ProportionsCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.redAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Proportions Calculator'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _margin = 10.0;

  double _result = 0;
  String _errorMessage = '';

  var _aText = TextEditingController();
  var _bText = TextEditingController();
  var _cText = TextEditingController();
  var _dText = TextEditingController();

  double _a = 0;
  double _b = 0;
  double _c = 0;
  double _d = 0;

  void handleAChange(String value) {
    setState(() {
      this._a = this._getDoubleValue(value);
    });
  }

  void handleBChange(String value) {
    setState(() {
      this._b = this._getDoubleValue(value);
    });
  }

  void handleCChange(String value) {
    setState(() {
      this._c = this._getDoubleValue(value);
    });
  }

  void handleDChange(String value) {
    setState(() {
      this._d = this._getDoubleValue(value);
    });
  }

  double _getDoubleValue(String value) {
    return value == '' ? 0 : double.parse(value);
  }

  void _calculate() {
    removeFocus(context);
    if (validate()) {
      setState(() {
        if (_a == 0) {
          this._result = _b * _c / _d;
        } else if (_b == 0) {
          this._result = _a * _d / _c;
        } else if (_c == 0) {
          this._result = _a * _d / _b;
        } else {
          this._result = _b * _c / _a;
        }
        this._errorMessage = '';
      });
    } else {
      setState(() {
        this._errorMessage =
            'Please enter any 3 values to determine the output';
      });
    }
  }

  bool validate() {
    return [_a, _b, _c, _d].where((item) => item > 0).toList().length == 3;
  }

  void _reset() {
    removeFocus(context);
    setState(() {
      this._aText.clear();
      this._bText.clear();
      this._cText.clear();
      this._dText.clear();
      this._result = 0;
      this._errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(_margin),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: Text('A : B = C : D',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ))),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: TextField(
                    controller: _aText,
                    decoration: InputDecoration(
                        labelText: 'A',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                    onChanged: this.handleAChange,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp(r'\d+(.\d*)?')),
                    ],
                  ),
                ),
                Container(
                  width: 150.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: TextField(
                    controller: _bText,
                    decoration: InputDecoration(
                        labelText: 'B',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                    onChanged: this.handleBChange,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp(r'\d+(.\d*)?')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: TextField(
                    controller: _cText,
                    decoration: InputDecoration(
                        labelText: 'C',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                    onChanged: this.handleCChange,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp(r'\d+(.\d*)?')),
                    ],
                  ),
                ),
                Container(
                  width: 150.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: TextField(
                    controller: _dText,
                    decoration: InputDecoration(
                        labelText: 'D',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                    onChanged: this.handleDChange,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp(r'\d+(.\d*)?')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: RaisedButton(
                    child: Text(
                      'Calculate',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _calculate,
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                    color: Colors.redAccent,
                  ),
                ),
                Container(
                  width: 150.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: RaisedButton(
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _reset,
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: this._errorMessage == ''
                ? EdgeInsets.symmetric(vertical: 0)
                : EdgeInsets.only(
                  top: 30.0,
                  left: 20.0,
                  ),
            child: Text(this._errorMessage,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.0),
            child: Text('Result',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  color: Colors.black87,
                )),
          ),
          Container(
            child: Text('$_result',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange,
                )),
          ),
        ]),
      ),
    );
  }
}
