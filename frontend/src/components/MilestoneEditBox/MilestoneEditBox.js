import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import { flexColumn, flexCenter, flex } from '@styles/utils';
import { SubmitButton, CancelButton } from '@shared';
import { colors } from '@styles/variables';
import { milestoneService } from '../../services/milestone.service';
import { useHistory, useLocation } from 'react-router-dom';

const Form = styled.form`
  width: 100%;
  ${flexColumn}
`;
const Container = styled.div`
  margin-bottom: 10px;
  margin-top: 16px;
  padding-bottom: 5px;
  border-top: 1px solid ${colors.borderColor};
  border-bottom: 1px solid ${colors.borderColor};
`;
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
  border: 1px solid ${colors.borderColor};
  font-size: 16px;
`;
const Textarea = styled.textarea`
  height: 200px;
  width: 700px;
  padding: 8px;
  overflow: auto;
  background-color: #fafbfc;
  border-radius: 6px;
  border: 1px solid ${colors.borderColor};
  font-size: 14px;
  resize: none;
`;
const SubmitBox = styled.div`
  margin: 5px 60px;
  display: flex;
  justify-content: flex-end;
`;
const CancelDiv = styled.div`
  ${flexCenter}
`;
const ButtonSpace = styled.div`
  margin-left: 7px;
`;
export default function MilestoneEditBox({ isNew }) {
  const [form, setForm] = useState({ title: '', dueDate: '', description: '' });
  const [isClosed, setIsClosed] = useState(false);
  const { title, dueDate, description } = form;

  const history = useHistory();
  const location = useLocation();

  const handleChange = ({ target }) => {
    const { name, value } = target;
    setForm({ ...form, [name]: value });
  };

  useEffect(() => {
    if (location.state) {
      setForm({
        ...form,
        title: location.state.title ?? '',
        dueDate: location.state.dueDate ?? '',
        description: location.state.description ?? '',
      });
      setIsClosed(location.state.isClosed);
    }
  }, []);

  const handleSubmit = async e => {
    e.preventDefault();
    try {
      const { data, status } = await milestoneService.addMilestones({
        title,
        dueDate: dueDate === '' ? null : dueDate,
        description,
      });
      if (status === 201) {
        history.push('/milestones');
        return;
      }
    } catch (err) {
      console.error(err);
    }
  };

  const handleClose = async () => {
    await milestoneService.closeMilestones(location.state.no);
    setIsClosed(true);
  };

  const handleOpen = async () => {
    await milestoneService.openMilestones(location.state.no);
    setIsClosed(false);
  };

  const handleCancel = () => {
    history.goBack();
  };

  const handleSaveChange = async () => {
    await milestoneService.editMilestones({
      no: location.state.no,
      title,
      dueDate: dueDate === '' ? null : dueDate,
      description,
    });
    history.push('/milestones');
  };

  return (
    <Form onSubmit={handleSubmit}>
      <Container>
        <InputBox>
          <Label htmlFor="milestone_title">Title</Label>
          <Input
            type="text"
            name="title"
            onChange={handleChange}
            id="milestone_title"
            placeholder="Title"
            value={title}
            required
          />
        </InputBox>
        <InputBox>
          <Label htmlFor="milestone_date">Due date (Optional)</Label>
          <Input
            type="date"
            name="dueDate"
            onChange={handleChange}
            id="milestone_date"
            placeholder="yyyy-mm-dd"
            value={dueDate}
          />
        </InputBox>
        <InputBox>
          <Label htmlFor="milestone_description">Description</Label>
          <Textarea
            name="description"
            onChange={handleChange}
            cols="40"
            rows="20"
            value={description}
            required
          />
        </InputBox>
      </Container>
      <SubmitBox>
        {isNew ? (
          <SubmitButton>Create milestone</SubmitButton>
        ) : (
          <CancelDiv>
            <ButtonSpace>
              <CancelButton type="button" onClick={handleCancel}>
                Cancel
              </CancelButton>
            </ButtonSpace>
            <ButtonSpace>
              {!isClosed ? (
                <CancelButton type="button" onClick={handleClose}>
                  Close milestone
                </CancelButton>
              ) : (
                <CancelButton type="button" onClick={handleOpen}>
                  Open milestone
                </CancelButton>
              )}
            </ButtonSpace>
            <ButtonSpace>
              <SubmitButton type="button" onClick={handleSaveChange}>
                Save changes
              </SubmitButton>
            </ButtonSpace>
          </CancelDiv>
        )}
      </SubmitBox>
    </Form>
  );
}
