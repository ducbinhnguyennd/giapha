String getThongBao(int month, int day) {
  if ([1, 4, 7, 10].contains(month)) {
     if ([6, 12, 18, 24, 30].contains(day)) {
       return 'Hao Thuong (Good)';
     } else if ([5, 11, 17, 23, 29].contains(day)) {
       return 'Thief';
     } else if ([4, 10, 16, 22, 28].contains(day)) {
       return 'Pure Yang (Good)';
     } else if ([1, 7, 13, 19, 25].contains(day)) {
       return 'Tang Phong (Pawn)';
     } else if ([2, 8, 14, 20, 26].contains(day)) {
       return 'Golden Earth';
     } else if ([3, 9, 15, 21, 27].contains(day)) {
       return 'Golden (Pawn)';
     }
   } else if ([2, 5, 8, 11].contains(month)) {
     if ([1, 9, 17, 25].contains(day)) {
       return 'Thien Dao';
     } else if ([8, 16, 24, 30].contains(day)) {
       return 'Thien Thuong (Good)';
     } else if ([7, 15, 23].contains(day)) {
       return 'Tianhou';
     } else if ([6, 14, 22].contains(day)) {
       return 'Thien Duong (Good)';
     } else if ([2, 10, 18, 26].contains(day)) {
       return 'Thien Mon (Good)';
     } else if ([3, 11, 19, 27].contains(day)) {
       return 'Heaven (Good)';
     } else if ([4, 12, 20, 28].contains(day)) {
       return 'Genius (Good)';
     } else if ([5, 13, 21, 29].contains(day)) {
       return 'Heavenly Thief';
     }
   } else if ([3, 6, 9, 12].contains(month)) {
     if ([1, 9, 17].contains(day)) {
       return 'Chu Thuc';
     } else if ([8, 16, 24, 30].contains(day)) {
       return 'Thanh Long Tuc';
     } else if ([7, 15, 25, 23].contains(day)) {
       return 'Qing Long Kiep (Good)';
     } else if ([6, 14, 22].contains(day)) {
       return 'Where is the dragon fruit (Pawn)';
     } else if ([2, 10, 18, 26].contains(day)) {
       return 'White Tiger Head (Pawn)';
     } else if ([3, 11, 19, 27].contains(day)) {
       return 'Bach Ho Kiep (Pawn)';
     } else if ([4, 12, 20, 28].contains(day)) {
       return 'White Tiger';
     } else if ([5, 13, 21, 29].contains(day)) {
       return 'Huyen Vu';
     }
   }

   return '';
}
