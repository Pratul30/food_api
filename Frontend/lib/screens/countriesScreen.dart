import 'package:flutter/material.dart';
import 'package:flutter_app/providers/view%20models/auth.vm.dart';
import 'package:flutter_app/widgets/loading.widget.dart';
import 'package:flutter_app/widgets/searchInputWidget.dart';
import 'package:provider/provider.dart';

final searCtrl = TextEditingController();

class CountriesScreen extends StatefulWidget {
  String value;
  CountriesScreen({Key key, @required this.value}) : super(key: key);

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  String typeValue = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthVM>(context, listen: false).availableCountries();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _countries = Provider.of<AuthVM>(context);

    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            title: Text(
              widget.value == 'phone'
                  ? 'Available countries'
                  : 'Available currencies',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            backgroundColor: Colors.orange,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: Center(
                    child: SearchInputWidget(
                  onChanged: (value) {
                    if (value.trim().isNotEmpty) {
                      setState(() {
                        typeValue = value;
                      });
                    } else {
                      setState(() {
                        typeValue = "";
                      });
                    }
                    _countries.countrieFiltersFun(value);
                  },
                  searchCtrl: searCtrl,
                  placeholder: 'Enter currency, country or dial-code',
                  clear: () {
                    setState(() {
                      typeValue = "";
                      searCtrl.clear();
                    });
                    _countries.countrieFiltersFun('');
                  },
                )),
              ),
            )),
        backgroundColor: Colors.grey[100],
        body: _countries.isLoading
            ? Center(child: LoadingWidget())
            : _countries.countries.length != 0
                ? typeValue != ""
                    ? _countries.countrieFilters.length != 0
                        ? ListView.builder(
                            itemCount: _countries.countrieFilters.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  child: listCountries(
                                      _countries.countrieFilters[index]),
                                  onTap: () {
                                    var data;
                                    if (widget.value == 'phone') {
                                      data = {
                                        'dialCode':
                                            _countries.countrieFilters[index]
                                                ['phone_code'],
                                        'country':
                                            _countries.countrieFilters[index]
                                                ['country_code'],
                                      };
                                    } else {
                                      data = {
                                        'currency':
                                            _countries.countrieFilters[index]
                                                ['currency_code'],
                                        'country':
                                            _countries.countrieFilters[index]
                                                ['country_name'],
                                      };
                                    }
                                    Navigator.pop(context, data);
                                  },
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              "No payment method\nfound",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[800],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                    : ListView.builder(
                        itemCount: _countries.countries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              child: listCountries(_countries.countries[index]),
                              onTap: () {
                                var data;
                                if (widget.value == 'phone') {
                                  data = {
                                    'dialCode': _countries.countries[index]
                                        ['phone_code'],
                                    'country': _countries.countries[index]
                                        ['country_code'],
                                  };
                                } else {
                                  data = {
                                    'currency': _countries.countries[index]
                                        ['currency_code'],
                                    'country': _countries.countries[index]
                                        ['country_name'],
                                  };
                                }
                                Navigator.pop(context, data);
                              },
                            ),
                          );
                        },
                      )
                : _countries.error != ""
                    ? Center(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/close.png',
                            height: 65.0,
                            width: 65.0,
                            color: Colors.grey[600],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            _countries.error,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ))
                    : Center(
                        child: Text(
                          "No payment method\nfound",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[800],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ));
  }

  Widget listCountries(var data) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Center(
                child: Text(
                    widget.value == 'phone'
                        ? "+${data['phone_code']}"
                        : "${data['currency_code']}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // data['country_name']
                Text(
                  widget.value == 'phone'
                      ? data['country_name']
                      : data['currency_name'],
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      overflow: TextOverflow.ellipsis),
                  overflow: TextOverflow.visible,
                ),
                SizedBox(height: 5.0),
                Text(
                    widget.value == 'phone'
                        ? "Currency: ${data['currency_code']}"
                        : "Country: ${data['country_name']}",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12.0)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
