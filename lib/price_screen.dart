import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;



class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    
  }
  String selectedCurrency = 'USD';

  String cryptoCurrency = 'BTC';
  //String fiatCurrency = 'USD';
  String cryptoValue = '?';
  
  void getData() async{
    try {
      double data = await CoinData().getCoinData(selectedCurrency, cryptoCurrency);
      setState(() {
        cryptoValue = data.toStringAsFixed(0);
    });
    }catch(e){
      print(e);
    }
  }

  List<Widget> getRateList(){
    List<Widget> rateList=[];

    for (String crypto in cryptoList){
      setState(() {
        cryptoCurrency = crypto;
        getData();
      });
      Widget rateCard = Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $cryptoCurrency = $cryptoValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
          rateList.add(rateCard);
    }
    rateList.add(Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            //using ternary operator
            //child: Platform.isIOS? iOSPicker():androidDropdown(),
            child: androidDropdown(),
          ));
    return rateList;
  }

  DropdownButton<String> androidDropdown(){
    List<DropdownMenuItem<String>> dropdownListItems = [];
    for(int i =0; i<currenciesList.length; i++)
    {
      dropdownListItems.add(DropdownMenuItem(
                  child: Text(currenciesList[i]),
                  value: currenciesList[i],));
    }
     return DropdownButton<String>(
              value: selectedCurrency,//the initial item that is displayed
              items: dropdownListItems,//this expects a list of string items
              onChanged: (value){
                setState(() {
                  selectedCurrency = value;
                  getData();
                });
              },
            );
  }


  CupertinoPicker iOSPicker(){
    List<Text> pickerItems=[];
    for (String currency in currenciesList){
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 30,
      children: pickerItems,//this expects a list of Text widgets
      onSelectedItemChanged: (selectedIndex){
        //do sth with selectedIndex
        // maybe selectedItemTEXTWIDGET=pickerItems[selectedIndex];
      print(selectedIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:getRateList()
      ),
    );
  }
}
