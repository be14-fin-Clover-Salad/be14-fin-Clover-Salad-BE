package com.clover.salad.contract.query.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.clover.salad.contract.query.dto.ContractDTO;
import com.clover.salad.contract.query.dto.ContractResponseDTO;
import com.clover.salad.contract.query.dto.ContractSearchDTO;
import com.clover.salad.contract.query.mapper.ContractMapper;
import com.clover.salad.employee.query.dto.EmployeeQueryDTO;
import com.clover.salad.employee.query.mapper.EmployeeMapper;
import com.clover.salad.security.SecurityUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ContractServiceImpl implements ContractService {

	private final ContractMapper contractMapper;
	private final EmployeeMapper employeeMapper;

	@Autowired
	public ContractServiceImpl(ContractMapper contractMapper, EmployeeMapper employeeMapper) {
		this.contractMapper = contractMapper;
		this.employeeMapper = employeeMapper;
	}

	@Override
	public List<ContractDTO> findContractInfo(int employeeId) {
		return contractMapper.selectContractInfo(employeeId);
	}

	@Override
	public List<ContractDTO> searchContracts(int dummy, ContractSearchDTO dto) {
		int me = SecurityUtil.getEmployeeId();

		if (SecurityUtil.hasRole("ROLE_MANAGER")) {
			EmployeeQueryDTO meEnt = employeeMapper.findEmployeeById(me);
			String workPlace = meEnt.getWorkPlace();
			dto.setWorkPlace(workPlace);
			dto.setEmployeeId(null);
		} else {
			dto.setEmployeeId(me);
			dto.setWorkPlace(null);
		}

		return contractMapper.searchContracts(me, dto);
	}

	@Override
	public ContractResponseDTO findDetailInfo(int contractId) {
		return contractMapper.selectDetailContractInfo(contractId);
	}

	@Override
	public List<Integer> getCustomerIdsByEmployee(int employeeId) {
		return contractMapper.findCustomerIdsByEmployeeId(employeeId);
	}

	@Override
	public Boolean contractValidationById(int contractId) {
		return contractMapper.existsById(contractId);
	}
}
