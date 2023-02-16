import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:http/http.dart" as http;
import '../Providers/products.dart';
import '../model/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-products";

  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var newProduct =
      Product(id: "", title: "", description: "", price: 0.0, imageUrl: "");
  var _initValue={
    'title':'',
    'description':'',
    'price':'',
    'imageUrl':''
  };

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
  }
  var _isInit =true;
  var _isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit)
      {
        final productId= ModalRoute.of(context)?.settings.arguments as dynamic ;
        if (productId!=null) {
        newProduct = Provider.of<Products>(context, listen: false).findById(productId);
        _initValue={  'title':newProduct.title,
          'description':newProduct.description,
          'price':newProduct.price.toString(),
          'imageUrl':''};
        _imageController.text=newProduct.imageUrl;
      }
    }
    _isInit=false;
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageController.text.isNotEmpty || (  !_imageController.text.startsWith("https")  && !_imageController.text.startsWith("http")) || (!_imageController.text.endsWith('.jpg') && !_imageController.text.endsWith('.png')))
    {
      return ;
    }
      setState(() {});}
  }

  Future <void> saveForm() async   {
  final isValid=  _form.currentState?.validate();
    if (!isValid!){
      return ;
    }
  _form.currentState?.save();
    setState(() {
      _isLoading=true;
    });
    if(newProduct.id.isNotEmpty) {
      Provider.of<Products>(context, listen: false).updateProduct(newProduct.id,newProduct);
      setState(() {
        _isLoading=false;
      });
      Navigator.of(context).pop();
    }
    else{
      try{
        await Provider.of<Products>(context, listen: false).addProduct(newProduct);
        print("Yes");
      }
      catch(err){
        print("NOOOOOOO");
        print(err);
        await  showDialog(context: context, builder: (ctx) {
          return AlertDialog(title: const Text("Something went wrong"),
            content: const Text("An error occured"),
            actions: [TextButton(onPressed: (){
              Navigator.of(ctx).pop();
            }, child: const Text("Ok"))],);
        });
      }
      finally{
        setState(() {
          _isLoading=false;
        });
        Navigator.of(context).pop();
      }
    }


    /*print(newProduct.price);
    print(newProduct.imageUrl);
    print(newProduct.imageUrl);*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product "),
        actions: [
          IconButton(
              onPressed: () {
                saveForm();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body:_isLoading?Container(alignment:Alignment.center,child: const CircularProgressIndicator(),):Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form,
          child: ListView(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Title"),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              onSaved: (value) {
                newProduct = Product(
                    id: newProduct.id,
                    title: value!,
                    description: newProduct.description,
                    price: newProduct.price,
                    imageUrl: newProduct.imageUrl,
                    isFavourite: newProduct.isFavourite);
              },
              validator: (value){
                if (value!.isEmpty)
                  {
                    return "Please Provide a value";
                  }
                return null;
              },
              initialValue: _initValue['title'],
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Price"),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              initialValue: _initValue['price'],
              onSaved: (value) {
                newProduct = Product(
                    id: newProduct.id,
                    title: newProduct.title,
                    description: newProduct.description,
                    price: double.parse(value!),
                    imageUrl: newProduct.imageUrl);
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              validator: (value) {
                  if(value!.isEmpty){
                    return 'Please enter a price';
                  }
                  if(double.tryParse(value)==null){
                    return 'Please enter a valid Price';
                  }
                  if (double.parse(value)<=0)
                    {
                      return 'Please enter a value more than 0';
                    }
                  return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Description"),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              initialValue: _initValue['description'],
              onSaved: (value) {
                newProduct = Product(
                    id: newProduct.id,
                    title: newProduct.title,
                    description: value!,
                    price: newProduct.price,
                    imageUrl: newProduct.imageUrl,
                    isFavourite: newProduct.isFavourite);
              },
              validator: (value) {
                 if(value!.isEmpty){
                   return "Description cannot be Empty";
                 }
                 if (value.length<10)
                   {
                     return "Enter a description with more than 10 letters";
                   }
                 return null ;
              },
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 8, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: _imageController.text.isEmpty
                      ? const Text("Enter a url")
                      : FittedBox(
                          child: Image.network(
                            _imageController.text,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageController,
                    focusNode: _imageUrlFocusNode,
                    onSaved: (value) {
                      newProduct = Product(
                          id: newProduct.id,
                          title: newProduct.title,
                          description: newProduct.description,
                          price: newProduct.price,
                          imageUrl: value!,
                          isFavourite: newProduct.isFavourite);
                    },
                    onFieldSubmitted: (_) {
                      saveForm();
                    },
                    onEditingComplete: () {
                      setState(() {});
                    },
                    validator: (value){
                      if (value!.isEmpty)
                        {
                          return 'Please enter a image URL';
                        }
                      if(!value.startsWith("https")  && !value.startsWith("http"))
                        {
                          return 'Please enter a valid URL';
                        }
                      if (!value.endsWith('.jpg') && !value.endsWith('.png') && !value.endsWith('jpeg'))
                        {
                          return 'Please enter a valid image URL';
                        }
                      return null;
                    },
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
