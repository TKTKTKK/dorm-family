package com.dorm.family.mapper;

import com.dorm.common.base.BaseMapper;
import com.dorm.family.entity.Address;
import com.dorm.family.entity.Student;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentMapper extends BaseMapper<Student> {

    Student selectStudentForSave(@Param("student") Student student);

    PageList<Student> selectStuListWithPagination(@Param("student") Student student, PageBounds pageBounds);

    void delteDormHead(@Param("student") Student student);
}
