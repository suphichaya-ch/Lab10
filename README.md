รายงานการทำงานแอปพลิเคชัน (Lab9)
1. หน้าโปรไฟล์ผู้ใช้ (User Profile)
การทำงาน: ดึงข้อมูลจาก user.name.firstname และ user.email มาโชว์ผ่าน UserProvider

จุดเด่น: จัดวางเมนูแยกส่วนชัดเจน (Edit Profile, Settings) เน้นความเป็นส่วนตัว

<img src="https://github.com/user-attachments/assets/7cca0d4c-004c-49a7-8eb2-f1f267304d99" width="300" />

2. หน้าแสดงรายการสินค้า (Product List)
การทำงาน: เรียก fetchProducts() จาก API และแสดงผลแบบ Grid View

จุดเด่น: มีระบบ Wishlist และทางลัดเพิ่มลงตะกร้า กดที่รูปเพื่อดูรายละเอียด

<img src="https://github.com/user-attachments/assets/9ecda8bf-25e5-4ba5-a9ba-6cd12d58ecd8" width="300" />

3. หน้ารายละเอียดสินค้า (Product Detail)
การทำงาน: ใช้ cartProvider.addItem(product) เมื่อกดปุ่มสั่งซื้อ

จุดเด่น: แสดงข้อมูล Rating และ Description ครบถ้วน ดีไซน์ทันสมัย

<img src="https://github.com/user-attachments/assets/d164defe-3d71-40d1-8fc7-d59c32fc16f8" width="300" />

4. หน้าตะกร้าสินค้า (Cart Screen)
การทำงาน: คำนวณ totalAmount แบบ Real-time ผ่าน CartProvider

จุดเด่น: สามารถเพิ่ม/ลดจำนวนสินค้าได้ทันทีในหน้านี้

<img src="https://github.com/user-attachments/assets/d6d7c2b4-feb5-46f2-ac82-ea00a9e15535" width="300" />

5. ระบบจัดการสำหรับผู้ดูแล (Admin Dashboard)
การทำงาน: แสดงสถิติรวม (Stats) ของ Users และ Products ในระบบ

จุดเด่น: เข้าถึงฟังก์ชันจัดการข้อมูลส่วนกลางได้ในหน้าเดียว

<img src="https://github.com/user-attachments/assets/9aad82ed-4034-46ce-89d1-78cf3db1cde1" width="400" />

6. หน้าแก้ไขข้อมูลผู้ใช้ (User Form)
การทำงาน: ใช้ userProvider.updateUser ส่งข้อมูลที่แก้ไขกลับไปยัง API

จุดเด่น: มีระบบ Validation ตรวจสอบความถูกต้องของข้อมูลก่อนบันทึก

<img src="https://github.com/user-attachments/assets/8935fbd1-7da0-47d5-a8c4-6ee97da5be80" width="400" />

7. หน้ารายการสินค้าสำหรับแอดมิน (Product Management)
การทำงาน: ใช้สำหรับ Monitor สินค้าทั้งหมดในคลัง

จุดเด่น: แตกต่างจากหน้า User ตรงที่เน้นข้อมูลเพื่อการจัดการสต็อก

<img src="https://github.com/user-attachments/assets/0f211688-3bd5-497f-917a-ff0f89841fc3" width="400" />


