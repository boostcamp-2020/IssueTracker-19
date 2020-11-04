import React, { useState } from 'react';
import styled from 'styled-components';
import { API } from '@api';
import { flexColumn } from '@styles/utils';

const InputBox = styled.label`
  ${flexColumn}
  margin:10px;
`;
const Label = styled.label`
  font-size: 14px;
  font-weight: 600;
  margin-bottom: 6px;
`;
const Input = styled.input`
  width: 440px;
  padding: 5px 12px;
  background-color: #fafbfc;
  border-radius: 6px;
  border: 1px solid #e1e4e8;
  font-size: 16px;
`;
const Textarea = styled.textarea`
  height: 200px;
  width: 600px;
  padding: 8px;
  overflow: auto;
  background-color: #fafbfc;
  border-radius: 6px;
  border: 1px solid #e1e4e8;
  font-size: 14px;
`;
export default function MilestoneEditBox() {
  return (
    <>
      <form>
        <InputBox>
          <Label htmlFor="milestone_title">Title</Label>
          <Input type="text" id="milestone_title" placeholder="Title" />
        </InputBox>
        <InputBox>
          <Label htmlFor="milestone_date">Due date (Optional)</Label>
          <Input type="date" id="milestone_date" placeholder="yyyy-mm-dd" />
        </InputBox>
        <InputBox>
          <Label htmlFor="milestone_description">Description</Label>
          <Textarea cols="40" rows="20" />
        </InputBox>
      </form>
    </>
  );
}
