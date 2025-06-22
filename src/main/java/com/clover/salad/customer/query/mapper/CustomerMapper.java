package com.clover.salad.customer.query.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.clover.salad.customer.query.dto.CustomerQueryDTO;

@Mapper
public interface CustomerMapper {

        List<CustomerQueryDTO> findAll();

        List<CustomerQueryDTO> findCustomersByIds(@Param("customerIds") List<Integer> customerIds);

        CustomerQueryDTO findCustomerByEmployeeAndCustomerId(@Param("customerId") int customerId,
                        @Param("customerIds") List<Integer> customerIds);

        CustomerQueryDTO findCustomerById(@Param("id") int id); // 관리자용 (삭제 포함)

        CustomerQueryDTO findCustomerByIdExcludingDeleted(@Param("id") int id); // 사원용 (삭제 제외)

        /* 25. 06. 12 성연님 요청 사항 */
        Integer findRegisteredCustomerId(@Param("customerName") String customerName,
                        @Param("customerBirthdate") String customerBirthdate,
                        @Param("customerPhone") String customerPhone);

        boolean existsContractByCustomer(@Param("name") String name,
                        @Param("birthdate") String birthdate, @Param("phone") String phone);

        boolean existsConsultByCustomer(@Param("name") String name,
                        @Param("birthdate") String birthdate, @Param("phone") String phone);
}
