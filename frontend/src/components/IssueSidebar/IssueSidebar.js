import React, { useEffect, useRef, useState } from 'react';
import styled from 'styled-components';
import { OptionSelectModal } from '@components';
import { colors } from '@styles/variables';
import { flex } from '@styles/utils';
import GearIcon from './GearIcon/GearIcon';
import { userService, labelService, milestoneService } from '@services';
import { LabelIcon, ListItem } from '@shared';

const MainContainer = styled.div`
  flex-direction: column;
  flex: 1;
  margin-right: 5rem;
  padding-left: 0.5rem;
`;

const Box = styled.div`
  padding: 1.5rem 1rem 0 1rem;
  font-size: 0.8rem;
  color: ${colors.black5};
`;

const BoxTitle = styled.span`
  font-weight: bold;
`;

const Line = styled.div`
  height: 0.5px;
  width: 100%;
  margin-top: 1rem;
  background-color: ${colors.lighterGray};
`;

const AssigneeBox = styled(Box)``;
const LabelBox = styled(Box)``;
const MilestoneBox = styled(Box)``;

const Header = styled.div`
  position: relative;
  ${flex('space-between', 'center')}
  cursor: pointer;
  &:hover {
    color: ${colors.resetFilterColor};
    svg {
      fill: ${colors.resetFilterColor};
    }
  }
`;

const Content = styled.div`
  font-weight: 300;
  font-size: 0.75rem;
  padding: 0.8rem 0 0 0;
`;

const AssignMySelfButton = styled.span`
  cursor: pointer;
  &:hover {
    color: ${colors.resetFilterColor};
  }
`;

const Modal = styled.div`
  position: absolute;
  top: 1.8rem;
  right: 0;
  outline: 0;
  z-index: 2;
`;

const MyListItem = styled(ListItem)`
  display: block;
`;

const IconBox = styled.div`
  ${flex('flex-start', 'center')}
  display: inline-flex;
`;

const EllipsisDiv = styled.div`
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
`;

const IconTitle = styled(EllipsisDiv)`
  width: 12rem;
`;

const IconDesc = styled(EllipsisDiv)`
  width: 12rem;
  padding: 0.2rem 0;
  font-size: 0.7rem;
  color: ${colors.black7};
`;

export default function IssueSidebar(props) {
  const {
    assignees,
    labels,
    milestone,
    handleAssignToMe,
    handleClickAssignee,
    handleClickLabel,
    handleClickMilestone,
  } = props;

  const [modalItems, setModalItems] = useState({ users: [], labels: [], milestones: [] });

  const assigneeModalRef = useRef();
  const labelModalRef = useRef();
  const milestoneModalRef = useRef();

  const [visiableAssigneeModal, setVisiableAssigneeModal] = useState(false);
  const [visiableLabelModal, setVisiableLabelModal] = useState(false);
  const [visiableMilestoneModal, setVisiableMilestoneModal] = useState(false);

  const openAssigneeModal = () => {
    if (assignees.length === 10) {
      alert('assignee는 최대 10명까지만 할당할 수 있습니다.');
      return;
    }
    setVisiableAssigneeModal(true);
    assigneeModalRef.current.focus();
  };

  const closeAssigneeModal = () => setVisiableAssigneeModal(false);

  const openLabelModal = () => {
    setVisiableLabelModal(true);
    labelModalRef.current.focus();
  };

  const closeLabelModal = () => setVisiableLabelModal(false);

  const openMilestoneModal = () => {
    setVisiableMilestoneModal(true);
    milestoneModalRef.current.focus();
  };

  const closeMilestoneModal = () => setVisiableMilestoneModal(false);

  const fetchAllModalItems = async () => {
    try {
      const [
        {
          data: { users },
        },
        {
          data: { labels },
        },
        {
          data: { milestones },
        },
      ] = await Promise.all([
        userService.getUsers(),
        labelService.getLabels(),
        milestoneService.getMilestones(),
      ]);
      setModalItems({ users, labels, milestones });
    } catch (err) {
      if (err?.response?.status === 401) {
        history.push('/login');
      }
      console.error(err);
    }
  };

  useEffect(() => {
    fetchAllModalItems();
  }, []);

  return (
    <MainContainer>
      <AssigneeBox>
        <Header onClick={openAssigneeModal}>
          <BoxTitle>Assignees</BoxTitle>
          <GearIcon fillColor={colors.black8} />
          <Modal tabIndex={0} ref={assigneeModalRef} onBlur={closeAssigneeModal}>
            <OptionSelectModal
              visiable={visiableAssigneeModal}
              setVisiable={setVisiableAssigneeModal}
              title={'Assign up to 10 people to this issue'}
              width={'19rem'}
            >
              {modalItems.users
                .filter(u => !assignees.some(a => a.no === u.no))
                .map(({ no, nickname }) => (
                  <ListItem key={no} onClick={e => handleClickAssignee(e, { no, nickname })}>
                    {nickname}
                  </ListItem>
                ))}
            </OptionSelectModal>
          </Modal>
        </Header>
        <Content>
          {assignees && assignees.length ? (
            assignees.map(({ no, nickname }) => <div key={no}>{nickname}</div>)
          ) : (
            <div>
              No one—
              <AssignMySelfButton onClick={handleAssignToMe}>assign yourself</AssignMySelfButton>
            </div>
          )}
          <Line />
        </Content>
      </AssigneeBox>

      <LabelBox>
        <Header onClick={openLabelModal}>
          <BoxTitle>Labels</BoxTitle>
          <GearIcon fillColor={colors.black8} />
          <Modal tabIndex={0} ref={labelModalRef} onBlur={closeLabelModal}>
            <OptionSelectModal
              visiable={visiableLabelModal}
              setVisiable={setVisiableLabelModal}
              title={'Apply labels to this issue'}
              width={'19rem'}
            >
              {modalItems.labels
                .filter(labelItems => !labels.some(l => l.no === labelItems.no))
                .map(({ no, name, color, description }) => (
                  <MyListItem
                    key={no}
                    onClick={e => handleClickLabel(e, { no, name, color, description })}
                  >
                    <IconBox>
                      <LabelIcon color={color} />
                      <IconTitle>{name}</IconTitle>
                    </IconBox>
                    <IconDesc>{description}</IconDesc>
                  </MyListItem>
                ))}
            </OptionSelectModal>
          </Modal>
        </Header>
        <Content>
          {labels && labels.length
            ? labels.map(({ no, name }) => <div key={no}>{name}</div>)
            : 'None yet'}
        </Content>
        <Line />
      </LabelBox>

      <MilestoneBox>
        <Header onClick={openMilestoneModal}>
          <BoxTitle>Milestone</BoxTitle>
          <GearIcon fillColor={colors.black8} />
          <Modal tabIndex={0} ref={milestoneModalRef} onBlur={closeMilestoneModal}>
            <OptionSelectModal
              visiable={visiableMilestoneModal}
              setVisiable={setVisiableMilestoneModal}
              title={'Set milestone'}
              width={'19rem'}
            >
              {modalItems.milestones
                .filter(m => m.no !== milestone?.no)
                .map(({ no, title }) => (
                  <ListItem key={no} onClick={e => handleClickMilestone(e, { no, title })}>
                    <IconTitle>{title}</IconTitle>
                  </ListItem>
                ))}
            </OptionSelectModal>
          </Modal>
        </Header>
        <Content>{milestone ? <div>{milestone.title}</div> : 'None yet'}</Content>
        <Line />
      </MilestoneBox>
    </MainContainer>
  );
}
