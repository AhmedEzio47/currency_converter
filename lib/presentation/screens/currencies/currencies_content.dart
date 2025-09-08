import 'package:currency_converter/presentation/currencies/bloc/currencies_bloc.dart';
import 'package:currency_converter/presentation/widgets/base_bloc_consumer.dart';
import 'package:currency_converter/presentation/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';

class CurrenciesContent extends StatelessWidget {
  const CurrenciesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BaseBlocConsumer<CurrenciesBloc, CurrenciesState>(
          onSuccess: (_, state) => ListView.separated(
            separatorBuilder: (_, _) => const SizedBox(height: 5),
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                leadingAndTrailingTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                leading: FutureBuilder(
                  future: state.currencies?.currencies[index].flag,
                  builder: (context, snap) {
                    return CustomCachedImage(
                      imageUrl: snap.data ?? '',
                      hidePlaceholderBackground: true,
                      width: 25,
                    );
                  },
                ),
                tileColor: Theme.of(context).cardColor,
                title: Text(state.currencies?.currencies[index].name ?? ''),
              ),
            ),
            itemCount: state.currencies?.currencies.length ?? 0,
          ),
        ),
      ),
    );
  }
}
