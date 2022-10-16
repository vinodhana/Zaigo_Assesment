import 'package:zaigo_assesment/src/utils/constants.dart';
import 'package:zaigo_assesment/src/webservice/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/fetch_bloc/fetch_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FetchBloc _bloc = FetchBloc(CommonRepo());

  @override
  void initState() {
    super.initState();
    _bloc.add(GetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              showLogoutDialog(context);

            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              if (state is FetchSuccess) {
                return ListView.builder(
                    itemCount: state.userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 10,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  state.userList[index].profilePicture!,
                                  width: 100,
                                  height: 80,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.userList[index].name!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.black38),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      state.userList[index].email!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black38),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              }

              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
