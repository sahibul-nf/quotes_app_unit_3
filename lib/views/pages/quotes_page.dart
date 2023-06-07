import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quotes_app_unit_3/controllers/quotes_controller.dart';
import 'package:quotes_app_unit_3/views/themes/colors.dart';

import '../themes/typography.dart';
import '../widgets/icon_solid_light.dart';
import '../widgets/quotes_card.dart';
import 'quote_detail_page.dart';
import 'search_page.dart';

class QuotesPage extends ConsumerWidget {
  const QuotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotesState = ref.watch(getRandomQuotesProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            centerTitle: false,
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconSolidLight(
                  icon: PhosphorIcons.regular.magnifyingGlass,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SearchPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
            title: Text("Quotes", style: MyTypography.h2),
            expandedHeight: 116,
            elevation: 0,
            floating: true,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              expandedTitleScale: 1.0,
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 16,
              ),
              title: Text(
                "Quotes",
                style: MyTypography.h2,
              ),
            ),
          ),

          // nampilin data random quotes
          quotesState.when(
            data: (quotes) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: 16,
                        left: 16,
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
                  childCount: quotes.length,
                ),
              );
            },
            error: (error, _) {
              return SliverToBoxAdapter(
                child: Text(error.toString()),
              );
            },
            loading: () {
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: MyColors.primary,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
