import 'package:convert_app/func/convert.dart';
import 'package:flutter/material.dart';

class ConvertCurrency extends StatefulWidget {
  final rates;
  final Map currencies;
  const ConvertCurrency(
      {Key? key, required this.rates, required this.currencies})
      : super(key: key);

  @override
  _ConvertCurrencyState createState() => _ConvertCurrencyState();
}

class _ConvertCurrencyState extends State<ConvertCurrency> {
  TextEditingController amountController = TextEditingController();

  Color secColor = Color(0xFF2849E5);

  String dropdownFrom = 'USD';
  String dropdownTo = 'IDR';
  String converted = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          child: Column(
            children: [
              TextFormField(
                key: ValueKey('amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Amount',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: secColor,
                  ),
                ),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropdownFrom,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 20,
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownFrom = newValue!;
                          });
                        },
                        items: widget.currencies.keys
                            .toSet()
                            .toList()
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                          child: Icon(
                        Icons.arrow_right_alt_outlined,
                        color: Colors.white,
                      ))),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownTo,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          iconSize: 24,
                          isExpanded: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownTo = newValue!;
                            });
                          },
                          items: widget.currencies.keys
                              .toSet()
                              .toList()
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              _buildResult(converted),
              SizedBox(height: 18),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    setState(() {
                      converted = '${dropdownTo} ' +
                          convert(widget.rates, amountController.text,
                              dropdownFrom, dropdownTo);
                    });
                  },
                  child: Text('Convert'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResult(String result) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Result :'),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Text(
                result,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
