import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: 128,
                          height: 128,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Icon(
                            Icons.shuffle,
                            size: 96,
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Randomizer",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          "A simple randomizer app for your daily needs",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "Version 1.0.0",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Developed and Maintained by",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "Merza Bolivar",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Privacy",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "This app does not collect any personal information, every data is stored locally on your device.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Support",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "I made this app in my free time and it's open source, if you would like to help me, report an issue, have an idea, etc. Please open an issue on Github.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  icon: const FaIcon(FontAwesomeIcons.github),
                  label: const Text("Github"),
                  onPressed: () => _launchUrl("https://github.com/renzyo/randomizer"),
                ),
                ElevatedButton.icon(
                  icon: const FaIcon(FontAwesomeIcons.discord),
                  label: const Text("Discord"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Discord"),
                          content: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Discord doesn't allow add friend via link and I also doesn't have a server yet, so you have to add me manually if you want to chat with me.",
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Discord: Renzyo",
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Close"),
                            ),
                            TextButton(
                              onPressed: () => _launchUrl("https://discordapp.com/"),
                              child: const Text("Open Discord"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                ElevatedButton.icon(
                  icon: const FaIcon(FontAwesomeIcons.globe),
                  label: const Text("Website"),
                  onPressed: () => _launchUrl("https://merza.dev/"),
                ),
                ElevatedButton.icon(
                  icon: const FaIcon(FontAwesomeIcons.twitter),
                  label: const Text("Twitter"),
                  onPressed: () => _launchUrl("https://twitter.com/renzayoshida"),
                ),
                ElevatedButton.icon(
                  icon: const FaIcon(FontAwesomeIcons.envelope),
                  label: const Text("Email"),
                  onPressed: () =>
                      _launchUrl("mailto:merza.bolivar@gmail.com?subject=[Randomizer App]"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: Platform.isIOS
            ? LaunchMode.externalApplication
            : LaunchMode.externalNonBrowserApplication,
      );
    }
  }
}
