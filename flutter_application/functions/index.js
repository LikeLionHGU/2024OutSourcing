const functions = require('firebase-functions');
const admin = require('firebase-admin');
const serviceAccount = require('./onban-e3465-firebase-adminsdk-rhrah-333f06d435.json');
const {credential} = require("firebase-admin");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

exports.sendNotificationToAdmins = functions.region('asia-northeast3').firestore
    .document('orders/{docId}')
    .onCreate(async (snap, context) => {
        // 'users' 컬렉션에서 'isAdmin'이 true인 모든 사용자의 토큰을 조회합니다.
        const usersSnapshot = await admin.firestore().collection('users').where('role', '==', true).get();

        // 조회된 각 사용자의 토큰을 배열에 저장합니다.
        const tokens = usersSnapshot.docs.map(doc => doc.data().token).filter(token => token);

        if (tokens.length === 0) {
            console.log('No admin tokens found.');
            return null;
        }

        // 푸시 알림 페이로드 구성
        const payload = {
            notification: {
                title: '중요한 업데이트!',
                body: '새로운 정보가 추가되었습니다. 확인해주세요.',
                // 이미지를 포함하려면 이 줄을 추가하세요:
                image: 'https://firebasestorage.googleapis.com/v0/b/onban-e3465.appspot.com/o/Frame%201097.png?alt=media&token=1773d545-842c-4eb3-8511-5c643bc1817a'
            }
        };

        // 토큰 목록에 알림을 전송합니다.
        return admin.messaging().sendToDevice(tokens, payload)
            .then(response => {
                console.log('Successfully sent notification to admins:', response);
                return null;
            })
            .catch(error => {
                console.error('Error sending notification to admins:', error);
                return null;
            });
    });
    