import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quotes_app_unit_3/controllers/search_controller.dart';

import '../themes/colors.dart';
import '../themes/typography.dart';
import '../widgets/icon_solid_light.dart';
import '../widgets/quotes_card.dart';
import 'quote_detail_page.dart';

class SearchPage extends ConsumerWidget {
  SearchPage({super.key});

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchControllerProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconSolidLight(
          icon: PhosphorIcons.regular.caretLeft,
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          "Search Quote",
          style: MyTypography.h3,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 40,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Search bar
              Container(
                height: 52,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 0.0,
                ),
                decoration: BoxDecoration(
                  color: MyColors.secondary,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: IntrinsicWidth(
                    child: TextField(
                      onChanged: (value) {
                        print(value);

                        Future.delayed(
                          const Duration(seconds: 2),
                          () {
                            ref
                                .read(searchControllerProvider.notifier)
                                .searchQuotes(value);
                          },
                        );
                      },
                      controller: _textController,
                      cursorColor: MyColors.black,
                      decoration: InputDecoration(
                        hintText: "Find a quote here",
                        hintStyle: MyTypography.body1.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          PhosphorIcons.regular.magnifyingGlass,
                          color: MyColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              searchState.when(
                data: (quotes) {
                  if (quotes.isEmpty) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: MyColors.secondary,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              padding: const EdgeInsets.all(40),
                              child: Icon(
                                PhosphorIcons.fill.quotes,
                                size: 48,
                              ),
                            ),
                            const SizedBox(height: 50),
                            Text(
                              "It's empty here",
                              style: MyTypography.h2,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Try to find a quote by typing the keyword in the search bar above",
                              style: MyTypography.body1.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          // right: 16,
                          // left: 16,
                          bottom: 16,
                          top: index == 0 ? 100 : 0,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const QuoteDetailPage(
                                  content:
                                      "The best way to get started is to quit talking and begin doing. The best way to get started is to quit talking and begin doing. The best way to get started is to quit talking and begin doing.",
                                  author: "Rick Riordan",
                                  authorAvatar: "assets/img_avatar.png",
                                  authorJob:
                                      "Co-Founder of The Walt Disney Company",
                                ),
                              ),
                            );
                          },
                          child: QuotesCard(
                            author: quotes[index].author!,
                            authorAvatar: "assets/img_avatar.png",
                            authorJob: "Co-Founder of The Walt Disney Company",
                            content: quotes[index].content!,
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (error, _) {
                  return Text(error.toString());
                },
                loading: () {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: MyColors.primary,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
