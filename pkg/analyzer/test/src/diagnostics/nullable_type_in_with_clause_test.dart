// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/src/dart/analysis/experiments.dart';
import 'package:analyzer/src/error/codes.dart';
import 'package:analyzer/src/generated/engine.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../dart/resolution/driver_resolution.dart';

main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(NullableTypeInWithClauseTest);
  });
}

@reflectiveTest
class NullableTypeInWithClauseTest extends DriverResolutionTest {
  @override
  AnalysisOptionsImpl get analysisOptions =>
      AnalysisOptionsImpl()..enabledExperiments = [EnableString.non_nullable];

  test_class_nonNullable() async {
    assertNoErrorsInCode('''
class A {}
class B with A {}
''');
  }

  test_class_nullable() async {
    assertErrorCodesInCode('''
class A {}
class B with A? {}
''', [CompileTimeErrorCode.NULLABLE_TYPE_IN_WITH_CLAUSE]);
  }

  test_classAlias_withClass_nonNullable() async {
    assertNoErrorsInCode('''
class A {}
class B {}
class C = A with B;
''');
  }

  test_classAlias_withClass_nullable() async {
    assertErrorCodesInCode('''
class A {}
class B {}
class C = A with B?;
''', [CompileTimeErrorCode.NULLABLE_TYPE_IN_WITH_CLAUSE]);
  }

  test_classAlias_withMixin_nonNullable() async {
    assertNoErrorsInCode('''
class A {}
mixin B {}
class C = A with B;
''');
  }

  test_classAlias_withMixin_nullable() async {
    assertErrorCodesInCode('''
class A {}
mixin B {}
class C = A with B?;
''', [CompileTimeErrorCode.NULLABLE_TYPE_IN_WITH_CLAUSE]);
  }
}
