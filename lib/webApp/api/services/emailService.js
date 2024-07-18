import nodemailer from 'nodemailer';

const transporter = nodemailer.createTransport({
  service: 'Gmail',
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

export const sendVerificationCode = (email, code) => {
    
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to: email,
    subject: 'Email Verification Code',
    text: `Your verification code is ${code}`,
  };
  console.log(mailOptions)

  return transporter.sendMail(mailOptions);
  
};
