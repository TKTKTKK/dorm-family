package com.dorm.family.service;

import com.dorm.common.base.BaseService;
import com.dorm.common.utils.StringUtils;
import com.dorm.family.entity.Address;
import com.dorm.family.entity.Student;
import com.dorm.family.mapper.AddressMapper;
import com.dorm.family.mapper.StudentMapper;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class StudentService extends BaseService<StudentMapper,Student> {

    @Autowired
    public void setMapper(StudentMapper mapper) {
        super.setMapper(mapper);
    }

    public Student getStudentForSave(Student student) {
        return mapper.selectStudentForSave(student);
    }

    public PageList<Student> getStuListWithPagination(Student student, PageBounds pageBounds) {
        return mapper.selectStuListWithPagination(student,pageBounds);
    }

    public int setDormHead(String studentId) {
        if(StringUtils.isNotBlank(studentId)){

            Student student = new Student();
            student.setUuid(studentId);
            student = this.queryForObjectByPk(student);

            //删除原先此寝室舍长
            mapper.delteDormHead(student);

            student.setType("DORMHEAD");
            this.updatePartial(student);
            return 1;
        }else{
            return 0;
        }
    }
}
