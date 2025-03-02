class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restoreationScopeId: 'app',

          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        onGenerateTitle: (BuildContext context) 
          => AppLocalizations.of(context)!.appTitle,

        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        themeMode: settingsController.themeMode,

        onGenerateRoute: (RouteSettings routeSettings){
          return MaterialPageRoute<void> (
            settings: routeSettings,
            builder: (BuildContext context) {
              switch (routeSettings.name) {
                case SettingsView.routeName:
                  return SettingsView(controller: settingsController);
                case SampleItemDetailsView.routeName:
                  return const SampleItemDetailsView();
                case SampleItemListView.routeName:
                defaulte:
                  return const SampleItemListView();    
              }
            }
          )
        }
        )
      }
    )
  }
}
