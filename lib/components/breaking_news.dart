import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:palestine_archive/components/NewsTile.dart';
import 'package:provider/provider.dart';

import '../auth/provider.dart';


class BreakingNews extends StatefulWidget {
  const BreakingNews({
    Key? key,
  }) : super(key: key);

  @override
  State<BreakingNews> createState() => _BreakingNewsState();
}

class _BreakingNewsState extends State<BreakingNews> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, x) {

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  overflow: TextOverflow.fade,

                  'Title : ${provider.selectedNews.name}',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.fade,

                            provider.NewsFilterList.where((element) =>
                            element.id==provider.selectedNews.id

                            ).toList().isNotEmpty?
                            'Author : ${provider.NewsFilterList.where((element) =>
                        element.id==provider.selectedNews.id

                        ).toList().first.submitted_by_name}'
                        :'Author :',
                        style:
                        Theme.of(context).textTheme.headline6!.copyWith(),
                      ),
                    ),


                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child:Text(
                          overflow: TextOverflow.fade,

                          'Source: ${provider.selectedNews.source}'
                             , style: Theme.of(context).textTheme.headline6!.copyWith()),
                    ),


                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child:Text(
                          overflow: TextOverflow.fade,
                          provider.selectedNews.created_at!.split('T').isNotEmpty
                              && provider.selectedNews.created_at!.split('T').isNotEmpty?
                          'date: ${provider.selectedNews.created_at?.split('T').first} ${provider.selectedNews.created_at?.split('T').last.split('.').first}'
                              : 'date: ', style: Theme.of(context).textTheme.bodyLarge),
                    ),


                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(

                  child: Text(
                   // overflow: TextOverflow.ellipsis,
                      provider.selectedNews.description??'',
                   // maxLines: 2,
                    style: TextStyle(
                        color: Color(0xFF00416b),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  ),

              ],
            ),
          );});
        }
}