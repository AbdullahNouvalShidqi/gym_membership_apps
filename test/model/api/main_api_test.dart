import 'package:gym_membership_apps/model/api/main_api.dart';
import 'package:gym_membership_apps/model/article_model.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/model/home_class_model.dart';
import 'package:gym_membership_apps/model/instructor_model.dart';
import 'package:gym_membership_apps/model/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'main_api.mocks.dart';

@GenerateMocks([MainAPI])
void main() {
  group('Main API', () {
    final mainAPI = MockMainAPI();

    group('for class,', () {
      test('get all class returns user models list of classes', () async {
        when(mainAPI.getAllClass()).thenAnswer(
          (realInvocation) async => [
            ClassModel(
              id: 1,
              name: 'BaneTest',
              description: 'descriptionTest',
              startAt: DateTime.now(),
              endAt: DateTime.now().add(const Duration(hours: 2)),
              qtyUsers: 30,
              type: 'Online',
              price: 300000,
              location: 'Zoom Meeting',
              images: ['images'],
              instructor: InstructorModel(
                id: 1,
                name: 'TestName',
                email: 'test@gmail.com',
                contact: '087823232237',
              ),
            ),
          ],
        );
        var classes = await mainAPI.getAllClass();
        expect(classes.isNotEmpty, true);
      });

      test('get class by id, returns user models one class with the same id', () async {
        when(mainAPI.getClassById(id: 1)).thenAnswer(
          (realInvocation) async => ClassModel(
            id: 1,
            name: 'Gym Class',
            description: 'class description',
            startAt: DateTime.now(),
            endAt: DateTime.now().add(const Duration(hours: 2)),
            qtyUsers: 30,
            type: 'Offline',
            price: 300000,
            location: 'Indonesia',
            images: ['images'],
            instructor: InstructorModel(
              id: 1,
              name: 'Name Test',
              email: 'test@gmail.com',
              contact: '0878123123123',
            ),
          ),
        );
        var classById = await mainAPI.getClassById(id: 1);
        expect(classById.id == 1, true);
        expect(classById.name == 'Gym Class', true);
        expect(classById.description == 'class description', true);
      });
      test('get home class, returns user models list of homeclassmodel data', () async {
        when(mainAPI.getHomeClass()).thenAnswer(
          (realInvocation) async => [
            HomeClassModel(
              name: 'Gym',
              description: 'class description',
              images: ['images'],
              instructor: InstructorModel(
                id: 1,
                name: 'name test',
                email: 'test@gmail.com',
                contact: '0823891279',
              ),
            ),
          ],
        );
        var homeClasses = await mainAPI.getHomeClass();
        expect(homeClasses.isNotEmpty, true);
      });

      test('get articles, returns user models list of article models', () async {
        when(mainAPI.getArticles()).thenAnswer(
          (realInvocation) async => [
            ArticleModel(
              imageUrl: 'imageUrl',
              title: 'article title',
              url: 'url to see article',
            ),
            ArticleModel(
              imageUrl: 'imageUrl',
              title: 'article title',
              url: 'url to see article',
            ),
          ],
        );
        var articles = await mainAPI.getArticles();
        expect(articles.isNotEmpty, true);
        expect(articles.length > 1, true);
      });
    });

    group('for user,', () {
      test('get all user, returns user models', () async {
        when(mainAPI.getAllUser()).thenAnswer(
          (realInvocation) async => [
            UserModel(
              id: 0,
              username: 'username',
              email: 'email@gmail.com',
              contact: '0817231231',
              password: 'Test12345',
            ),
            UserModel(
              id: 1,
              username: 'username',
              email: 'email@gmail.com',
              contact: '0817231231',
              password: 'Test12345',
            ),
          ],
        );
        var allUsers = await mainAPI.getAllUser();
        expect(allUsers.isNotEmpty, true);
        expect(allUsers.length > 1, true);
      });
    });

    test('sign up, returns user model that sign up', () async {
      when(mainAPI.signUp()).thenAnswer(
        (realInvocation) async => UserModel(
          id: 0,
          username: 'Test',
          email: 'test@gmail.com',
          contact: '089817231',
          password: 'TEst1234',
        ),
      );
      var user = await mainAPI.signUp();
      expect(user.id != null, true);
      expect(user.username.isNotEmpty, true);
    });
  });
}
