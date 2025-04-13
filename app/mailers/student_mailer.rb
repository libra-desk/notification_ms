class StudentMailer < ApplicationMailer
  def book_borrowed(student_email)
    mail(to: student_email, subject: "Related to your recent borrowal")
  end

  def book_returned(student_email)
    mail(to: student_email, subject: "Related to your recent return of the book")
  end
end
